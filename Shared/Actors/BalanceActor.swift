//
//  BalanceActor.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 03.12.2022.
//

import BigInt
import Core
import Combine
import Foundation

final class BalanceActor {
    let balance = CurrentValueSubject<Value?, Never>(nil)
    let address: Address
    private let transactionActor: TransactionActor
    private var cancellable: Cancellable?
    
    init(
        address: Address,
        transactionActor: TransactionActor
    ) {
        self.address = address
        self.transactionActor = transactionActor
    }
    
    func startPolling() {
        cancellable = Timer.publish(every: 6, on: .main, in: .default)
            .autoconnect()
            .prepend(Date())
            .await { [weak self] _ in
                guard let self = self else { return nil }
                let value = try await self.transactionActor.web3.eth.getBalance(
                    for: self.address.address
                )
                return Value(value)
            }
            .receive(on: RunLoop.main)
            .assign(to: \.value, on: balance)
    }
}


