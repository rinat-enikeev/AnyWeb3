//
//  Address.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 04.12.2022.
//

import Core
import Foundation

struct Address: Hashable, Identifiable {
    var id: String { address.address }
    var address: EthereumAddress
    
    init(address: EthereumAddress) {
        self.address = address
    }
}
