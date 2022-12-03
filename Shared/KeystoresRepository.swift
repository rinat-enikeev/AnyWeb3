//
//  KeystoresRepository.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 03.12.2022.
//

import Combine
import Foundation

final actor KeystoresRepository {
    init() {
        if let mnemonicsURL = Bundle.main.url(forResource: "mnemonics", withExtension: "") {
            if let mnemonics = try? String(contentsOf: mnemonicsURL) {
                print(mnemonics)
            }
        }
    }
}
