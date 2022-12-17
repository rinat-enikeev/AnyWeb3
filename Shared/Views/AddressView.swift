//
//  AddressView.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 04.12.2022.
//

import Factory
import SwiftUI

struct AddressView: View {
    @State var isNetworksPresented = false
    @State var isKeystoresPresented = false
    
    var body: some View {
        VStack {
            BalanceView()
            .padding()
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Account") {
                    isKeystoresPresented = true
                }
                .sheet(isPresented: $isKeystoresPresented) {
                    NavigationStack {
                        AccountsView()
                        Button("Close") {
                            isKeystoresPresented = false
                        }
                        .padding()
                    }
                    .presentationDetents([.medium, .large])
                }
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Network") {
                    isNetworksPresented = true
                }
                .sheet(isPresented: $isNetworksPresented) {
                    VStack {
                        NetworksView()
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
    @State var account: Account = .demo
    
    var body: some View {
        AddressView()
    }
}
#endif

