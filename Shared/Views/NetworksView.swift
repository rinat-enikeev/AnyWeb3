//
//  NetworksView.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 03.12.2022.
//

import SwiftUI

struct NetworksView: View {
    let networks: [Network] = [.development, .ethereum, .gnosis]
    @Binding var network: Network
    
    var body: some View {
        VStack {
            let selection = Binding<Network?>(
                get: { network },
                set: { network = $0 ?? .development }
            )
            List(networks, id: \.self, selection: selection) { network in
                Text(network.name)
            }
        }
    }
}

//struct NetworksView_Previews: PreviewProvider {
//    static var previews: some View {
//        NetworksView()
//    }
//}

