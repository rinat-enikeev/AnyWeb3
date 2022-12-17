//
//  AccountsView.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 04.12.2022.
//

import Factory
import SwiftUI

enum AccountsState {
    case idle
    case loading
    case error
}

struct AccountsView: View {
    @State
    private var state: AccountsState = .idle
    @Injected(Container.userRepository)
    private var userRepository
    @Injected(Container.accountsRepository)
    private var accountsRepository
    @Injected(Container.accountService)
    private var accountService
    
    var body: some View {
        VStack {
            switch state {
            case .idle:
                List(
                    accountsRepository.accounts,
                    id: \.self,
                    selection: userRepository.accountBinding
                ) { account in
                    Text(account.firstAddress, format: .shorten)
                }
            case .loading:
                ProgressView()
            case .error:
                Text("Error")
                Button("OK") {
                    state = .idle
                }
            }
        }
        .navigationTitle("Accounts")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Add") {
                    state = .loading
                    Task {
                        do {
                            try await accountService.createAccount()
                            await MainActor.run {
                                state = .idle
                            }
                        } catch {
                            await MainActor.run {
                                state = .error
                            }
                        }
                    }
                }
            }
        }
    }
}
