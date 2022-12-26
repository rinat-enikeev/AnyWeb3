//
//  Transaction.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 09.12.2022.
//

import BigInt
import Foundation

struct Transaction: Hashable {
    var from: Address?
    var to: Address?
    var value: Value?
    var gasLimit: Value?
    var gasPrice: Value?

    var nonce: BigUInt = 0
    var chainId: BigUInt = 0
    var data: Data = Data()
    var v: BigUInt = 1
    var r: BigUInt = 0
    var s: BigUInt = 0
}

extension Transaction {
    static var zero: Self {
        Transaction(from: .zero, to: .zero)
    }
}
