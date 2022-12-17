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
    private let userDefaults: UserDefaults
    
    init() {
        let userDefaults: UserDefaults = .standard
        let keychain = Keychain(service: Bundle.main.bundleIdentifier ?? "eu.enikeev")
        self.accounts = keychain.allKeys().compactMap {
            guard let mnemonics = keychain[$0] else { return nil }
            guard let name = userDefaults.string(forKey: $0) else { return nil }
            return Account(id: $0, name: name, mnemonics: mnemonics)
        }
        self.keychain = keychain
        self.userDefaults = userDefaults
        accounts.append(.demo)
    }
    
    func appendAccount(_ account: Account) {
        keychain[account.id] = account.mnemonics
        accounts.append(account)
        userDefaults.setValue(account.name, forKey: account.id)
    }
}
