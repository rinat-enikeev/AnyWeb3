//
//  NetworksView.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 03.12.2022.
//

import SwiftUI

struct NetworksView: View {
    @EnvironmentObject var state: AppState
    @State var networks: [Network] = [.development, .gnosis, .ethereum]
    
    var body: some View {
        List(networks) { network in
            NavigationLink(value: network) {
                Text(network.name)
            }
        }
        .navigationTitle("Networks")
    }
}
