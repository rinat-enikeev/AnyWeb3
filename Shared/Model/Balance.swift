//
//  Balance.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 04.12.2022.
//

import Foundation

final class Balance: ObservableObject, Hashable, Identifiable {
    var id: UUID = UUID()
    var repository: BalanceRepository
    
    init(balanceRepository: BalanceRepository) {
        self.repository = balanceRepository
    }
    
    static func == (lhs: Balance, rhs: Balance) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
