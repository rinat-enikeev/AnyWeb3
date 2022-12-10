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
            VStack {
                Text(state.network.name)
                Text(state.address, format: .shorten)
                NavigationStack(path: $state.path) {
                    AddressView(
                        address: $state.address,
                        network: $state.network,
                        transaction: $state.transaction
                    )
                    .navigationDestination(for: Transaction.self) { transaction in
                        TransactionView(
                            transaction: $state.transaction,
                            network: $state.network
                        )
                        .environmentObject(state)
                    }
                    .environmentObject(state)
                }
            }
        }
    }
}
