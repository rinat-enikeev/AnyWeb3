//
//  App.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 03.12.2022.
//

import BigInt
import Core
import Combine
import SwiftUI

@main
struct App: SwiftUI.App {
    @StateObject var state = AppState()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $state.path) {
                NetworksView()
                    .navigationDestination(for: Network.self) { network in
                        NetworkView(network: network)
                            .environmentObject(state)
                    }
                    .navigationDestination(for: Connection.self) { connection in
                        KeystoreView()
                            .environmentObject(state)
                    }
                    .navigationDestination(for: Address.self) { address in
                        AddressView(address: address)
                            .environmentObject(state)
                    }
                    .environmentObject(state)
            }
            
            .task(priority: .medium) {
                do {
                    #if DEBUG
                    try await state.keystoreRepository.loadDebug()
                    #endif
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

class AppState: ObservableObject {
    @Published var path = NavigationPath()
    @Published var address: Address?
    @Published var balance: Balance?
    @Published var network: Network?
    @Published var connection: Connection?
    @Published var addresses = [Address]()

    let keystoreRepository = KeystoreRepository()
    var balanceRepository: BalanceRepository?
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        keystoreRepository.addresses
            .receive(on: RunLoop.main)
            .map { $0.map { Address(address: $0) } }
            .assign(to: &$addresses)
    }
    
    func startPollingBalance(address: Address) async {
        guard let connection else {
            assertionFailure()
            return
        }
        let balanceRepository = BalanceRepository(address: address.address, connection: connection)
        do {
            try await balanceRepository.startPolling()
        } catch {
            print(error.localizedDescription)
        }
        await MainActor.run {
            balance = Balance(balanceRepository: balanceRepository)
        }
    }
    
    func establishConnection(_ network: Network) async {
        let networkRepository = await NetworkRepository(network)
        await MainActor.run {
            connection = Connection(networkRepository: networkRepository)
        }
    }
}
