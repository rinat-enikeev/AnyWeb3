//
//  Address.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 04.12.2022.
//

import Core
import Foundation

final class Address: ObservableObject, Hashable, Identifiable {
    var id: UUID = UUID()
    var address: EthereumAddress
    
    init(address: EthereumAddress) {
        self.address = address
    }
    
    static func == (lhs: Address, rhs: Address) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
