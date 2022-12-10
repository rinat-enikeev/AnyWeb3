//
//  Account.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 04.12.2022.
//

import Foundation

struct Account: Hashable, Identifiable {
    var id: String { name }
    var name: String
    var mnemonics: String
}

extension Account {
    static var demo: Self {
        let mnemonicsURL = Bundle.main.url(forResource: "mnemonics", withExtension: "")!
        let mnemonics = try! String(contentsOf: mnemonicsURL)
        return Account(name: "Development", mnemonics: mnemonics)
    }
}
