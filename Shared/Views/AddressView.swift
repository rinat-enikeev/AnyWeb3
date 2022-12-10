//
//  AddressView.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 04.12.2022.
//

import SwiftUI

struct AddressView: View {
    let address: Address
    @EnvironmentObject var state: AppState
    
    var body: some View {
        VStack {
            BalanceView(balance: $state.balance)
                .padding()
            ToAddressView(from: address)
        }
        .navigationTitle(address.address.address)
        .task {
            await state.startPollingBalance(address: address)
        }
    }
}
