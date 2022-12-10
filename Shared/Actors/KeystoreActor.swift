//
//  KeystoreActor.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 03.12.2022.
//

import Core
import Combine
import Foundation
import web3swift

actor KeystoreActor {
    let keystore: Keystore
    nonisolated let addresses = CurrentValueSubject<[EthereumAddress], Never>([])

    private let password: String
    private let language: BIP39Language
    init(
        keystore: Keystore,
        password: String,
        language: BIP39Language
    ) {
        self.keystore = keystore
        self.password = password
        self.language = language
    }
    
    func load() throws {
        guard let debugKeystore = try BIP32Keystore(mnemonics: keystore.mnemonics, password: password, language: language) else {
            assertionFailure()
            return
        }
        guard let address = debugKeystore.addresses?.first else {
            assertionFailure()
            return
        }
        addresses.value.append(address)
        for i in 1...9 {
            guard let address = try generateAddress(debugKeystore: debugKeystore, i) else {
                assertionFailure()
                return
            }
            print(address.address)
            addresses.value.append(address)
        }
    }
    
    private func generateAddress(debugKeystore: BIP32Keystore, _ index: Int) throws -> EthereumAddress? {
        try debugKeystore.createNewCustomChildAccount(password: "", path: HDNode.defaultPath + "/\(index)")
        guard debugKeystore.addresses?.count ?? 0 > index else {
            assertionFailure()
            return nil
        }
        return debugKeystore.addresses?[index]
    }
}
