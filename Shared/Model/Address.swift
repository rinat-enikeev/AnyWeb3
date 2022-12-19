//
//  Address.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 04.12.2022.
//

import Foundation
import Web3Core
import web3swift


public struct Address: Codable, Hashable, Identifiable {
    public var id: String { address.address }
    public var address: EthereumAddress
    
    public init(address: EthereumAddress) {
        self.address = address
    }
}

extension Address {
    init?(address: String) {
        guard let address = EthereumAddress(address) else { return nil }
        self.init(address: address)
    }
}

extension Address {
    static var zero: Self {
        Address(address: .zero)
    }
}
