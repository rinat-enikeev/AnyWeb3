//
//  ToAddressView.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 10.12.2022.
//

import SwiftUI

struct ToAddressView: View {
    @Binding var transaction: Transaction

    var body: some View {
        let toBinding = Binding(
            get: { transaction.to.address.address },
            set: { transaction.to = Address(address: $0) ?? .zero }
        )
        HStack {
            NavigationLink(value: transaction) {
                Text("Send")
            }.disabled(transaction.to == .zero)
            Text(" to ")
            TextField("address", text: toBinding)
        }
        .padding()
    }
}
