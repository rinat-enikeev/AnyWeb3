//
//  App.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 03.12.2022.
//

import SwiftUI

@main
struct App: SwiftUI.App {
    @StateObject var state = AppState()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $state.path) {
                NetworksView()
                    .navigationDestination(for: Network.self) { network in
                        KeystoresView(keystores: $state.keystores, network: network)
                            .environmentObject(state)
                    }
                    .navigationDestination(for: Keystore.self) { keystore in
                        KeystoreView(addresses: $state.addresses, keystore: keystore)
                            .environmentObject(state)
                    }
                    .navigationDestination(for: Address.self) { address in
                        AddressView(address: address)
                            .environmentObject(state)
                    }
                    .environmentObject(state)
            }
            .task {
                do {
                    try await state.loadKeystores()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
