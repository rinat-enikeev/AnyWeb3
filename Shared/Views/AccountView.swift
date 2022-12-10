//
//  AccountView.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 03.12.2022.
//

import Core
import SwiftUI

struct AccountView: View {
    @StateObject var model = AccountModel()
    @Binding var address: Address
    let account: Account
    
    var body: some View {
        VStack {
            let selection = Binding<Address?>(
                get: { address },
                set: { address = $0 ?? .zero }
            )
            List(model.addresses, id: \.self, selection: selection) { address in
                Text(address, format: .shorten)
            }
        }
        .task {
            do {
                model.account = account
                try await model.load()
            } catch {
                print(error.localizedDescription)
            }
        }
        .navigationTitle(account.name)
    }
}

final class AccountModel: ObservableObject {
    @Published var addresses = [Address]()
    var account: Account = .demo
    
    func load() async throws {
        let actor = try AccountActor(account: account, password: "", language: .spanish)
        actor.addresses
            .receive(on: RunLoop.main)
            .assign(to: &$addresses)
        try await actor.startLoading()
    }
}

#if DEBUG
struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView_PreviewContainer()
    }
}

struct AccountView_PreviewContainer : View {
    @State var address: Address = .zero
    
    var body: some View {
        AccountView(address: $address, account: .demo)
    }
}
#endif
