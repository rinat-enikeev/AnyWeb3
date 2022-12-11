//
//  AddAccount.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 11.12.2022.
//

import SwiftUI

struct AddAccount: View {
    @State var name: String = ""
    @Binding var accounts: [Account]

    var body: some View {
        VStack {
            TextField("Name", text: $name)
            Button("Generate") {
                do {
                    let actor = try AccountActor(name: name, password: "", language: .spanish)
                    accounts.append(actor.account)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        .padding()
    }
}

#if DEBUG
struct AddAccount_Previews: PreviewProvider {
    static var previews: some View {
        AddAccount_PreviewContainer()
    }
}

struct AddAccount_PreviewContainer : View {
    @State var accounts: [Account] = [.demo]

     var body: some View {
         AddAccount(accounts: $accounts)
     }
}
#endif
