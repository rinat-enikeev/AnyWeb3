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

    var body: some View {
        VStack {
            List(state.addresses) { address in
                NavigationLink(value: address) {
                    Text(address.address.address)
                }
            }
        }
    }
}
