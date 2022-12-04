//
//  KeystoresActor.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 04.12.2022.
//

import Combine
import Core
import Foundation
import web3swift

final actor KeystoresActor {
    func loadKeystores() throws -> [Keystore] {
        guard let mnemonicsURL = Bundle.main.url(forResource: "mnemonics", withExtension: "") else {
            assertionFailure()
            return []
        }
        let mnemonics = try String(contentsOf: mnemonicsURL)
        return [Keystore(name: "DEVELOP", mnemonics: mnemonics)]
    }
}
