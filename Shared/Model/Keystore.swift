//
//  Keystore.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 04.12.2022.
//

import Foundation

struct Keystore: Hashable, Identifiable {
    var id: String { name }
    var name: String
    var mnemonics: String
}
