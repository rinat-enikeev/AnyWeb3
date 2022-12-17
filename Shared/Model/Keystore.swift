//
//  Keystore.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 17.12.2022.
//

import Core
import Foundation

struct Keystore {
    var mnemonics: String
    var web3: AbstractKeystore
    
    var addresses: [Address]? {
        web3.addresses.map { $0.map(Address.init) } 
    }
}
