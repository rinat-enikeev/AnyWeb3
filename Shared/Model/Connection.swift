//
//  Connection.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 03.12.2022.
//

import Foundation

final class Connection: ObservableObject, Hashable, Identifiable {
    var id: UUID = UUID()
    var repository: NetworkRepository
    
    init(networkRepository: NetworkRepository) {
        self.repository = networkRepository
    }
    
    static func == (lhs: Connection, rhs: Connection) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
