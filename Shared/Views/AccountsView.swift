//
//  AccountsView.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 04.12.2022.
//

import SwiftUI

struct AccountsView: View {
    @State var accounts: [Account] = [.preview]
    
    var body: some View {
        List(accounts) { account in
            NavigationLink(value: account) {
                Text(account.name)
            }
        }
        .navigationTitle("Keystores")
    }
}
