//
//  AddressFormatStyle.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 10.12.2022.
//

import Foundation

extension FormatStyle where Self == ShortAddressFormatStyle {
    static var shorten: Self {
        ShortAddressFormatStyle()
    }
}

public struct ShortAddressFormatStyle: FormatStyle {
    public func format(_ value: Address) -> String {
        let firstSix = value.id.prefix(6)
        let lastFour = value.id.suffix(4)
        return firstSix + "..." + lastFour
    }
}

extension ParseableFormatStyle where Self == AddressFormatStyle {
    static var address: Self {
        AddressFormatStyle()
    }
}

public struct AddressFormatStyle: ParseableFormatStyle {
    public var parseStrategy: AddressParseStrategy {
        return AddressParseStrategy()
    }

    public func format(_ value: Address) -> String {
        value.address.address
    }
}

public struct AddressParseStrategy: ParseStrategy {
    enum Error: Swift.Error {
        case failedToParse
    }
    public func parse(_ value: String) throws -> Address {
        guard let address = Address(address: value) else {
            throw Error.failedToParse
        }
        return address
    }
}
