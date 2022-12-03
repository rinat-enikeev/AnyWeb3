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
            AsyncButton("Connect") {
                await state.establishConnection(network)
            }
            .buttonStyle(.bordered)
            .padding()
            NavigationLink(value: state.connection) {
                Text("Proceed")
            }
        }
    }
}

struct NetworkView_Previews: PreviewProvider {
    static var previews: some View {
        NetworkView(network: .development)
    }
}
