//
//  Keystore.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 03.12.2022.
//

import Core
import Foundation

struct Keystore: Identifiable {
    var id: String
    var value: AbstractKeystore
}
