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
    @EnvironmentObject var state: AppState
    @State var transaction: Transaction
    
    var body: some View {
        let valueBinding = Binding<String>(
            get: { transaction.value?.description ?? "0" },
            set: { transaction.value = BigUInt($0) }
        )
        VStack {
            HStack {
                Text("From: ")
                Text(transaction.from.address.address)
            }
            HStack {
                Text("To: ")
                Text(transaction.to.address.address)
            }
            TextField("Value", text: valueBinding)
            Button("Confirm") {
                Task {
                    do {
                        try await state.sendTransaction(transaction)
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
