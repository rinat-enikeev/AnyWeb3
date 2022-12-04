//
//  CryptoIntegerStyle.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 04.12.2022.
//

import BigInt
import Foundation

extension FormatStyle where Self == CryptoIntegerStyle<BigUInt> {
    static func crypto(decimals: Int = 18) -> Self {
        CryptoIntegerStyle(decimals: decimals)
    }
}

public struct CryptoIntegerStyle<Subject: BinaryInteger>: FormatStyle {
    private let decimals: Int
    private let separator: String
    init(
        decimals: Int,
        separator: String = "."
    ) {
        self.decimals = decimals
        self.separator = separator
    }
    
    public func format(_ value: Subject) -> String {
        var string = String(value)
        if string.count > decimals {
            for character in separator {
                string.insert(character, at: string.index(string.endIndex, offsetBy: -decimals))
            }
        } else if string.count == decimals {
            string = "0" + separator + string
        } else if value > 0 {
            var leading = "0" + separator
            for _ in string.count ..< decimals {
                leading += "0"
            }
            string = leading + string
        }
        return string
    }
}
