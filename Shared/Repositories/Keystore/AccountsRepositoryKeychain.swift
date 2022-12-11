//
//  AccountsRepositoryKeychain.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 11.12.2022.
//

import Combine
import Foundation
import KeychainAccess

final class AccountsRepositoryKeychain: AccountsRepository {
    let accounts: CurrentValueSubject<[Account], Never>
    var lastUsedAccount: Account? {
        get {
            guard let uuid = userDefaults.string(forKey: lastUsedAccountKey) else { return .demo }
            guard let mnemonics = keychain[uuid] else { return .demo }
            guard let name = userDefaults.string(forKey: uuid) else { return .demo }
            return Account(id: uuid, name: name, mnemonics: mnemonics)
        }
        set {
            userDefaults.set(newValue?.id, forKey: lastUsedAccountKey)
        }
    }
    private let lastUsedAccountKey = "AccountsRepositoryKeychain.lastUsedAccountKey"
    private let keychain: Keychain
    private let userDefaults: UserDefaults
    
    init() {
        let userDefaults: UserDefaults = .standard
        let keychain = Keychain(service: Bundle.main.bundleIdentifier ?? "eu.enikeev")
        self.accounts = CurrentValueSubject<[Account], Never>(keychain.allKeys().compactMap {
            guard let mnemonics = keychain[$0] else { return nil }
            guard let name = userDefaults.string(forKey: $0) else { return nil }
            return Account(id: $0, name: name, mnemonics: mnemonics)
        })
        self.keychain = keychain
        self.userDefaults = userDefaults
        accounts.value.append(.demo)
    }
    
    func storeAccount(_ account: Account) {
        keychain[account.id] = account.mnemonics
        accounts.value.append(account)
        userDefaults.setValue(account.name, forKey: account.id)
    }
}
