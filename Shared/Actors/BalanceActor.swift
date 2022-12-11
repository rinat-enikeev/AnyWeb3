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
    private let web3Actor: Web3Actor
    private var cancellable: Cancellable?
    
    init(
        address: Address,
        web3Actor: Web3Actor
    ) {
        self.address = address
        self.web3Actor = web3Actor
    }
    
    func startPolling() {
        cancellable = Timer.publish(every: 6, on: .main, in: .default)
            .autoconnect()
            .prepend(Date())
            .await { [weak self] _ in
                guard let self = self else { return nil }
                return Value(try await self.web3Actor.web3.eth.getBalance(for: self.address.address))
            }
            .assign(to: \.value, on: balance)
    }
}


