//
//  ValueFormatStyle.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 11.12.2022.
//

import BigInt
import Foundation

public extension FormatStyle where Self == ValueFormatStyle {
    static var fractional: Self {
        ValueFormatStyle()
    }
}

public struct ValueStrategy: ParseStrategy {
    public func parse(_ value: String) throws -> Value {
        return try Value(fractional: value)
    }
}

public struct ValueFormatStyle {
}
    
extension ValueFormatStyle: ParseableFormatStyle {
    public var parseStrategy: ValueStrategy {
        return ValueStrategy()
    }
    public func format(_ value: Value) -> String {
        value.fractional
    }
}
