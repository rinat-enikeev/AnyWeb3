//
//  KeystoreActor.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 17.12.2022.
//

import Core
import Combine
import Foundation
import web3swift

final actor KeystoreActor {
    enum Error: Swift.Error {
        case failedToInitialize
        case failedToGenerate
    }
    
    func generate(
        language: Language,
        password: String
    ) throws -> Keystore {
        let bitsOfEntropy: Int = 128
        guard let mnemonics = try BIP39.generateMnemonics(
            bitsOfEntropy: bitsOfEntropy,
            language: language.web3
        ) else {
            throw Error.failedToGenerate
        }
        guard let keystore = try BIP32Keystore(
            mnemonics: mnemonics,
            password: password,
            language: language.web3
        ) else {
            throw Error.failedToInitialize
        }
        return Keystore(mnemonics: mnemonics, web3: keystore)
    }
    
    func generate(
        mnemonics: String,
        language: Language,
        password: String
    ) throws -> Keystore {
        guard let keystore = try BIP32Keystore(
            mnemonics: mnemonics,
            password: password,
            language: language.web3
        ) else {
            throw Error.failedToInitialize
        }
        return Keystore(mnemonics: mnemonics, web3: keystore)
    }
}
