//
//  KeystoresView.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 04.12.2022.
//

import SwiftUI

struct KeystoresView: View {
    @EnvironmentObject var state: AppState
    @Binding var keystores: [Keystore]?
    let network: Network

    var body: some View {
        VStack {
            if let keystores {
                List(keystores) { keystore in
                    NavigationLink(value: keystore) {
                        Text(keystore.name)
                    }
                }
            } else {
                ProgressView()
            }
        }
        .navigationTitle(network.name)
        .task {
            await state.connect(network: network)
        }
    }
}
