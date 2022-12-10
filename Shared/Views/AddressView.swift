//
//  AddressView.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 04.12.2022.
//

import SwiftUI

struct AddressView: View {
    @Binding var address: Address
    @Binding var network: Network
    @Binding var transaction: Transaction

    @State var isNetworksPresented = false
    @State var isKeystoresPresented = false
    @State var isTransactionPresented = false
    
    var body: some View {
        VStack {
            BalanceView(address: $address, network: $network)
            .padding()
            Button("Send") {
                isTransactionPresented = true
            }
            .sheet(isPresented: $isTransactionPresented) {
                TransactionView(
                    transaction: $transaction,
                    network: $network
                )
                .presentationDetents([.medium])
            }
            Spacer()
        }
        .onChange(of: address) { _ in
            transaction.from = address
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Account") {
                    isKeystoresPresented = true
                }
                .sheet(isPresented: $isKeystoresPresented) {
                    NavigationStack {
                        AccountsView()
                            .navigationDestination(for: Account.self) { account in
                                AccountView(address: $address, account: account)
                            }
                        Button("Close") {
                            isKeystoresPresented = false
                        }
                        .padding()
                    }
                    .presentationDetents([.medium])
                }
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Network") {
                    isNetworksPresented = true
                }
                .sheet(isPresented: $isNetworksPresented) {
                    VStack {
                        NetworksView(network: $network)
                        Button("Close") {
                            isNetworksPresented = false
                        }
                        .padding()
                    }
                    .presentationDetents([.medium])
                }
            }
        }
    }
}

#if DEBUG
struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView_PreviewContainer()
    }
}

struct AddressView_PreviewContainer : View {
    @State var address: Address = .zero
    @State var network: Network = .development
    @State var transaction: Transaction = .zero

     var body: some View {
         AddressView(
             address: $address,
             network: $network,
             transaction: $transaction
         )
     }
}
#endif

