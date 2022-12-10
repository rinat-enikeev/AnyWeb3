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

#if DEBUG
struct ToAddressView_Previews: PreviewProvider {
    static var previews: some View {
        ToAddressView_PreviewContainer()
    }
}

struct ToAddressView_PreviewContainer : View {
    @State var transaction: Transaction = .zero

     var body: some View {
         ToAddressView(
            transaction: $transaction
         )
     }
}
#endif
