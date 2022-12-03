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

actor KeystoreRepository {
    nonisolated let addresses = CurrentValueSubject<[EthereumAddress], Never>([])
    nonisolated let keystore = CurrentValueSubject<AbstractKeystore?, Never>(nil)

    #if DEBUG
    func loadDebug() throws {
        guard let mnemonicsURL = Bundle.main.url(forResource: "mnemonics", withExtension: "") else {
            assertionFailure()
            return
        }
        let mnemonics = try String(contentsOf: mnemonicsURL)
        guard !Task.isCancelled else { return }
        guard let debugKeystore = try BIP32Keystore(mnemonics: mnemonics, password: "", language: .spanish) else {
            assertionFailure()
            return
        }
        keystore.value = debugKeystore
        guard let address = debugKeystore.addresses?.first else {
            assertionFailure()
            return
        }
        addresses.value.append(address)
        for i in 1...9 {
            guard !Task.isCancelled else { return }
            guard let address = try generateAddress(debugKeystore: debugKeystore, i) else {
                assertionFailure()
                return
            }
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
    #endif
}
