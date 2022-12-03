//
//  BalanceRepository.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 03.12.2022.
//

import BigInt
import Core
import Combine
import Foundation

final actor BalanceRepository {
    nonisolated let balance = CurrentValueSubject<BigUInt?, Never>(nil)
    let address: EthereumAddress
    let connection: Connection
    
    init(
        address: EthereumAddress,
        connection: Connection
    ) {
        self.address = address
        self.connection = connection
    }
    
    func startPolling() async throws {
        balance.value = try await connection.repository.web3.eth.getBalance(for: address)
    }
}
