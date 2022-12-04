//
//  NetworkView.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 04.12.2022.
//

import SwiftUI

struct NetworkView: View {
    @EnvironmentObject var state: AppState
    var network: Network

    var body: some View {
        VStack {
            KeystoreView()
        }
        .navigationTitle(network.name)
        .task(priority: .userInitiated) {
            await state.establishConnection(network)
        }
    }
}

struct NetworkView_Previews: PreviewProvider {
    static var previews: some View {
        NetworkView(network: .development)
    }
}
