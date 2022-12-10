//
//  Transaction.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 09.12.2022.
//

import BigInt
import Foundation

struct Transaction: Hashable {
    var from: Address
    var to: Address
    var value: BigUInt?
}

extension Transaction {
    static var preview: Self {
        Transaction(from: .zero, to: .zero)
    }
}
