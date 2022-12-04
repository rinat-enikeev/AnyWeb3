//
//  NetworksView.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 03.12.2022.
//

import SwiftUI

struct NetworksView: View {
    @EnvironmentObject var state: AppState
    #if DEBUG
    @State var networks: [Network] = [.development, .ethereum, .gnosis]
    #else
    @State var networks: [Network] = [.ethereum, .gnosis]
    #endif
    
    var body: some View {
        List(networks) { network in
            NavigationLink(value: network) {
                Text(network.name)
            }
        }
        .navigationTitle("Networks")
    }
}
