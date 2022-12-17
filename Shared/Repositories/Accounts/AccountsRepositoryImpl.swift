//
//  AccountsRepositoryImpl.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 11.12.2022.
//

import Combine
import Foundation
import KeychainAccess

final class AccountsRepositoryImpl: AccountsRepository {
    @Published var accounts: [Account]
    var accountsPublisher: Published<[Account]>.Publisher { $accounts }
    var accountsPublished: Published<[Account]> { _accounts }

    private let keychain: Keychain
    
    init() {
        let keychain = Keychain(service: Bundle.main.bundleIdentifier ?? "eu.enikeev")
        self.accounts = keychain.allKeys().compactMap {
            return Address(address: $0).map(Account.init)
        }
        self.keychain = keychain
    }
    
    func appendAccount(_ account: Account, keystore: Keystore) {
        keychain[account.id] = keystore.mnemonics
        accounts.append(account)
    }
}
