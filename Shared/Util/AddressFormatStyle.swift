//
//  AddressFormatStyle.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 10.12.2022.
//

import Foundation

extension FormatStyle where Self == AddressFormatStyle {
    static var shorten: Self {
        AddressFormatStyle()
    }
}

public struct AddressFormatStyle: FormatStyle {
    public func format(_ value: Address) -> String {
        let firstSix = value.id.prefix(6)
        let lastFour = value.id.suffix(4)
        return firstSix + "..." + lastFour
    }
}
