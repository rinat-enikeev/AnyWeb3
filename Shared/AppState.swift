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
    @Published var network: Network?
    @Published var keystores: [Keystore]?
    @Published var keystore: Keystore?
    @Published var addresses: [Address]?
    @Published var address: Address?
    @Published var balance: Balance?

    let keystoresActor = KeystoresActor()
    var keystoreActor: KeystoreActor?
    var balanceActor: BalanceActor?
    var web3Actor: Web3Actor?
    
    func loadKeystores() async throws {
        let result = try await keystoresActor.loadKeystores()
        await MainActor.run {
            keystores = result
        }
    }
    
    func loadAddresses(keystore: Keystore) async throws {
        guard keystoreActor?.keystore != keystore else { return }
        let keystoreActor = KeystoreActor(
            keystore: keystore,
            password: "",
            language: .spanish
        )
        keystoreActor
            .addresses
            .receive(on: RunLoop.main)
            .map { $0.map { Address(address: $0) } }
            .assign(to: &$addresses)
        self.keystoreActor = keystoreActor
        try await keystoreActor.load()
    }
    
    func startPollingBalance(address: Address) async {
        guard balanceActor?.address != address else { return }
        guard let web3Actor else {
            assertionFailure()
            return
        }
        let balanceActor = BalanceActor(
            address: address,
            web3Actor: web3Actor
        )
        balanceActor.startPolling()
        balanceActor.balance
            .receive(on: RunLoop.main)
            .map { Balance(value: $0)}
            .assign(to: &$balance)
        self.balanceActor = balanceActor
    }
    
    func connect(network: Network) async {
        guard self.network != network else { return }
        await MainActor.run {
            self.network = network
        }
        guard web3Actor?.network != network else { return }
        web3Actor = await Web3Actor(network)
    }
}
