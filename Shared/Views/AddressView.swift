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
            BalanceView(balance: $state.balance)
        }.task {
            await state.startPollingBalance(address: address)
        }
    }
}
