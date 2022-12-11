//
//  TransactionView.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 09.12.2022.
//

import BigInt
import Combine
import Core
import SwiftUI

struct TransactionView: View {
    @Binding var transaction: Transaction
    @Binding var network: Network
    
    var body: some View {
        let toBinding = Binding(
            get: { transaction.to.address.address },
            set: { transaction.to = Address(address: $0) ?? .zero }
        )
        VStack {
            HStack {
                Text("From: ")
                Text(transaction.from, format: .shorten)
            }
            HStack {
                Text("To: ")
                TextField("address", text: toBinding)
            }
            TextField("Value", value: $transaction.value, format: .fractional)
                .keyboardType(.decimalPad)
            Button("Confirm") {
                Task {
                    do {
                        let transactionActor = await TransactionActor(network)
                        try await transactionActor.sendTranscation(transaction)
                    } catch {
                        if let web3Error = error as? Web3Error {
                            print(web3Error.errorDescription)
                        }
                    }
                }
            }
            .disabled(transaction.value?.value == 0 || transaction.value?.value == nil)
        }.padding()
    }
}

#if DEBUG
struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionView_PreviewContainer()
    }
}

struct TransactionView_PreviewContainer : View {
    @State var network: Network = .development
    @State var transaction: Transaction = .zero

     var body: some View {
         TransactionView(
            transaction: $transaction,
            network: $network
         )
     }
}
#endif
