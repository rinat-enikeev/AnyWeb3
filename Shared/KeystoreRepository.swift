//
//  KeystoreRepository.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 03.12.2022.
//

import Core
import Combine
import Foundation
import web3swift

final actor KeystoreRepository {
    nonisolated let addresses = CurrentValueSubject<[EthereumAddress], Never>([])
    nonisolated let keystore = CurrentValueSubject<AbstractKeystore?, Never>(nil)
    
    #if DEBUG
    func loadDevelopmentAccount() throws {
        guard let mnemonicsURL = Bundle.main.url(forResource: "mnemonics", withExtension: "") else {
            assertionFailure()
            return
        }
        let mnemonics = try String(contentsOf: mnemonicsURL)
        guard let debugKeystore = try BIP32Keystore(mnemonics: mnemonics, password: "", language: .spanish) else {
            assertionFailure()
            return
        }
        keystore.value = debugKeystore
        keystore.value?.addresses
        try debugKeystore.createNewCustomChildAccount(password: "", path: HDNode.defaultPath + "/1")
        try debugKeystore.createNewCustomChildAccount(password: "", path: HDNode.defaultPath + "/2")
        try debugKeystore.createNewCustomChildAccount(password: "", path: HDNode.defaultPath + "/3")
        try debugKeystore.createNewCustomChildAccount(password: "", path: HDNode.defaultPath + "/4")
        try debugKeystore.createNewCustomChildAccount(password: "", path: HDNode.defaultPath + "/5")
        try debugKeystore.createNewCustomChildAccount(password: "", path: HDNode.defaultPath + "/6")
        try debugKeystore.createNewCustomChildAccount(password: "", path: HDNode.defaultPath + "/7")
        try debugKeystore.createNewCustomChildAccount(password: "", path: HDNode.defaultPath + "/8")
        try debugKeystore.createNewCustomChildAccount(password: "", path: HDNode.defaultPath + "/9")
    }
    #endif
}
