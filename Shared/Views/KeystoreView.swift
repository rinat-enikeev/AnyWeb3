//
//  KeystoreView.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 03.12.2022.
//

import Core
import SwiftUI

struct KeystoreView: View {
    @EnvironmentObject var state: AppState
    @Binding var addresses: [Address]?
    let keystore: Keystore
    
    var body: some View {
        VStack {
            if let addresses {
                List(addresses) { address in
                    NavigationLink(value: address) {
                        Text(address.address.address)
                    }
                }
            } else {
                ProgressView()
            }
        }
        .navigationTitle(keystore.name)
        .task(priority: .medium) {
            do {
                try await state.loadAddresses(keystore: keystore)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
