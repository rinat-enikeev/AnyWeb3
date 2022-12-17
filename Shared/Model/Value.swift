//
//  Value.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 11.12.2022.
//

import BigInt
import Foundation

public struct Value: Hashable {
    public let value: BigUInt
    enum Error: Swift.Error {
        case failedToParseValue
    }
    let decimals: Int = 18
    let separator: Character = "."
    
    var fractional: String {
        var string = String(value)
        if string.count > decimals {
            string.insert(separator, at: string.index(string.endIndex, offsetBy: -decimals))
        } else if string.count == decimals {
            string = "0" + String(separator) + string
        } else if value > 0 {
            var leading = "0" + String(separator)
            for _ in string.count ..< decimals {
                leading += "0"
            }
            string = leading + string
        }
        return string
    }
    
    init(_ value: BigUInt) {
        self.value = value
    }
    
    init(fractional: String) throws {
        guard let firstIndexOfSepearator = fractional.firstIndex(of: separator) else {
            guard let value = BigUInt(fractional) else {
                throw Error.failedToParseValue
            }
            self.value = value.multiplied(by: BigUInt(10).power(decimals))
            return
        }

        var right = fractional.suffix(from: firstIndexOfSepearator).dropFirst()
        guard right.count <= decimals else {
            throw Error.failedToParseValue
        }

        let left = fractional.prefix(upTo: firstIndexOfSepearator)
        let multiplicator = BigUInt(10).power(decimals)
        guard let leftValue = BigUInt(left)?.multiplied(by: multiplicator) else {
            throw Error.failedToParseValue
        }
        for _ in right.count ..< decimals {
            right += "0"
        }
        guard let rightValue = BigUInt(right) else {
            throw Error.failedToParseValue
        }
        self.value = leftValue + rightValue
    }
}
