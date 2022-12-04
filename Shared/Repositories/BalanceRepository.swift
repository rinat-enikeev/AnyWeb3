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

final class BalanceRepository {
    let balance = CurrentValueSubject<BigUInt?, Never>(nil)
    let address: EthereumAddress
    let connection: Connection
    private var cancellable: Cancellable?
    
    init(
        address: EthereumAddress,
        connection: Connection
    ) {
        self.address = address
        self.connection = connection
    }
    
    func startPolling() {
        cancellable = Timer.publish(every: 6, on: .main, in: .default)
            .autoconnect()
            .prepend(Date())
            .await { _ in
                try await self.connection.repository.web3.eth.getBalance(for: self.address)
            }
            .assign(to: \.value, on: balance)
    }
}


