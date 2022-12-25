//
//  DashboardView.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 04.12.2022.
//

import Factory
import SwiftUI

struct DashboardView: View {
    @State var isNetworksPresented = false
    @State var isAccountsPresented = false
    
    var body: some View {
        VStack {
            BalanceView()
                .padding()
            TransactionView()
                .padding()
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Account") {
                    isAccountsPresented = true
                }
                .sheet(isPresented: $isAccountsPresented) {
                    NavigationStack {
                        AccountsView()
                        Button("Close") {
                            isAccountsPresented = false
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
    var body: some View {
        DashboardView()
    }
}
#endif

