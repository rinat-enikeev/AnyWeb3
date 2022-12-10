//
//  AccountActor.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 03.12.2022.
//

import Core
import Combine
import Foundation
import web3swift

actor AccountActor {
    enum Error: Swift.Error {
        case failedToInitialize
        case failedToGenerate
    }
    let account: Account
    nonisolated let addresses = CurrentValueSubject<[Address], Never>([])

    private let password: String
    private let language: BIP39Language
    private let keystore: BIP32Keystore
    init(
        account: Account,
        password: String,
        language: BIP39Language
    ) throws {
        self.account = account
        self.password = password
        self.language = language
        guard let keystore = try BIP32Keystore(mnemonics: account.mnemonics, password: password, language: language) else {
            throw Error.failedToInitialize
        }
        self.keystore = keystore
        guard let address = keystore.addresses?.first else {
            throw Error.failedToGenerate
        }
        addresses.value.append(Address(address: address))
    }
    
    func startLoading() throws {
        for i in 1...9 {
            if Task.isCancelled { return }
            guard let address = try generateAddress(keystore: keystore, i) else {
                throw Error.failedToGenerate
            }
            addresses.value.append(Address(address: address))
        }
    }
    
    private func generateAddress(keystore: BIP32Keystore, _ index: Int) throws -> EthereumAddress? {
        try keystore.createNewCustomChildAccount(password: "", path: HDNode.defaultPath + "/\(index)")
        guard keystore.addresses?.count ?? 0 > index else {
            assertionFailure()
            return nil
        }
        return keystore.addresses?[index]
    }
}
