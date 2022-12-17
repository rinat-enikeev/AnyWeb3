//
//  Account.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 04.12.2022.
//
import Core
import Foundation

struct Account: Codable, Hashable, Identifiable {
    var id: String { firstAddress.id }
    var firstAddress: Address
}

extension Account {
    static var demo: Self {
        let mnemonicsURL = Bundle.main.url(forResource: "mnemonics", withExtension: "")!
        let mnemonics = try! String(contentsOf: mnemonicsURL)
        return Account(firstAddress: Address(address: EthereumAddress("0x5D669Db688c6b39F9d6A7186fdf1484643043909")!))
    }
}
