//
//  EthereumAddress+Identifiable.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 03.12.2022.
//

import Core

extension EthereumAddress: Identifiable {
    public var id: String {
        address
    }
}
