//
//  AccountsView.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 04.12.2022.
//

import Factory
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
    @Injected(Container.accountsRepository)
    private var accountsRepository
    
    init() {
        accountsRepository.accountsPublisher.assign(to: &$accounts)
    }
    
    func store(_ account: Account) {
        accountsRepository.appendAccount(account)
    }
}
