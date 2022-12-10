//
//  TransactionView.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 09.12.2022.
//

import BigInt
import Core
import SwiftUI

struct TransactionView: View {
    @Binding var transaction: Transaction
    @Binding var network: Network
    
    var body: some View {
        let valueBinding = Binding<String>(
            get: { transaction.value?.description ?? "0" },
            set: { transaction.value = BigUInt($0) }
        )
        VStack {
            HStack {
                Text("From: ")
                Text(transaction.from, format: .shorten)
            }
            HStack {
                Text("To: ")
                Text(transaction.to, format: .shorten)
            }
            TextField("Value", text: valueBinding)
            Button("Confirm") {
                Task {
                    do {
                        let web3Actor = await Web3Actor(network)
                        try await web3Actor.sendTranscation(transaction)
                    } catch {
                        if let web3Error = error as? Web3Error {
                            print(web3Error.errorDescription)
                        }
                    }
                }
            }
            .disabled(transaction.value == 0 || transaction.value == nil)
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
