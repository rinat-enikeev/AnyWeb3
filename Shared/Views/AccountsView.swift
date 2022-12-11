//
//  AccountsView.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 04.12.2022.
//

import SwiftUI

struct AccountsView: View {
    @StateObject var model = AccountsModel()
    @State var isAddAccountPresented = false

    var body: some View {
        List(model.accounts) { account in
            NavigationLink(value: account) {
                Text(account.name)
            }
        }
        .navigationTitle("Accounts")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Add") {
                    isAddAccountPresented = true
                }
                .sheet(isPresented: $isAddAccountPresented) {
                    NavigationStack {
                        AddAccount(accountsModel: model)
                        Button("Close") {
                            isAddAccountPresented = false
                        }
                        .padding()
                    }
                    .presentationDetents([.medium])
                }
            }
        }
    }
}

final class AccountsModel: ObservableObject {
    @Published var accounts: [Account] = []
    private var accountsRepository = AccountsRepositoryKeychain()
    
    init() {
        accountsRepository.accounts
            .receive(on: RunLoop.main)
            .assign(to: &$accounts)
    }
    
    func store(_ account: Account) {
        accountsRepository.storeAccount(account)
    }
}
