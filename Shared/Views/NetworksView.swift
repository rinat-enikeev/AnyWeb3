//
//  NetworksView.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 03.12.2022.
//

import Factory
import SwiftUI

struct NetworksView: View {
    let networks: [Network] = [.development, .ethereum, .gnosis]
    @Injected(Container.settingsRepository)
    private var settingsRepository
    
    var body: some View {
        VStack {
            List(networks, id: \.self, selection: settingsRepository.networkBinding) { network in
                Text(network.name)
            }
        }
    }
}

#if DEBUG
struct NetworksView_Previews: PreviewProvider {
    static var previews: some View {
        NetworksView_PreviewContainer()
    }
}

struct NetworksView_PreviewContainer : View {
    var body: some View {
        NetworksView()
    }
}
#endif
