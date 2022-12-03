//
//  AddressView.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 04.12.2022.
//

import SwiftUI

struct AddressView: View {
    @EnvironmentObject var state: AppState
    var address: Address
    
    var body: some View {
        VStack {
            AsyncButton("Balance") {
                await state.startPollingBalance(address: address)
            }
            .buttonStyle(.bordered)
            .padding()
            NavigationLink(value: state.balance) {
                Text("Proceed")
            }
        }
    }
}
