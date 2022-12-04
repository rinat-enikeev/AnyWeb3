//
//  KeystoresView.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 04.12.2022.
//

import SwiftUI

struct KeystoresView: View {
    @EnvironmentObject var state: AppState
    var network: Network
    @State var keystores = [Keystore]()

    var body: some View {
        List(keystores) { keystore in
            NavigationLink(value: keystore) {
                Text(keystore.name)
            }
        }
        .navigationTitle("Keystores")
        .navigationTitle(network.name)
        .task(priority: .userInitiated) {
            do {
                keystores = try await state.loadKeystores()
            } catch {
                print(error.localizedDescription)
            }
            state.establishConnection(network)
        }
    }
}

struct NetworkView_Previews: PreviewProvider {
    static var previews: some View {
        KeystoresView(network: .development)
    }
}
