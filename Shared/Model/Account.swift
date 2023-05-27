//
//  Account.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 04.12.2022.
//

import Foundation

struct Account: Codable, Hashable, Identifiable {
    var id: String { firstAddress.id }
    var firstAddress: Address
}
