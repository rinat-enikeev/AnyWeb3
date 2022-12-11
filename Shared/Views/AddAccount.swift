//
//  AddAccount.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 11.12.2022.
//

import SwiftUI

struct AddAccount: View {
    @State var name: String = ""
    @ObservedObject var accountsModel: AccountsModel

    var body: some View {
        VStack {
            TextField("Name", text: $name)
            Button("Generate") {
                do {
                    let actor = try AccountActor(name: name, password: "", language: .spanish)
                    accountsModel.store(actor.account)
                } catch {
                    print(error.localizedDescription)
                }
            }
            .disabled(name.isEmpty)
        }
        .padding()
    }
}
