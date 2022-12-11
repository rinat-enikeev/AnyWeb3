//
//  AppState.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 04.12.2022.
//

import BigInt
import Core
import Combine
import SwiftUI

class AppState: ObservableObject {
    @Published var path = NavigationPath()
    @Published var network: Network = .development
    @Published var account: Account = .demo
    @Published var address: Address = .zero
    @Published var transaction: Transaction = .zero
    private var subscribers: Set<AnyCancellable> = []
    private let accountsRepository = AccountsRepositoryKeychain()

    init() {
        loadLastUsedAccount()
        $account.sink { [weak self] account in
            self?.accountsRepository.lastUsedAccount = account
        }.store(in: &subscribers)
    }
    
    private func loadLastUsedAccount() {
        guard let account = accountsRepository.lastUsedAccount else {
            return
        }
        do {
            let accountActor = try AccountActor(account: account, password: "", language: .spanish)
            guard let address = accountActor.addresses.value.first else {
                return
            }
            self.address = address
            self.transaction = Transaction(from: address, to: .zero)
        } catch {
            print(error.localizedDescription)
        }
    }
}
