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
    var value: Value?
}

extension Transaction {
    static var zero: Self {
        Transaction(from: .zero, to: .zero)
    }
}
