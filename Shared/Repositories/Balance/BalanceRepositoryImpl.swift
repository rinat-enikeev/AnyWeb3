//
//  BalanceRepositoryImpl.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 17.12.2022.
//

import BigInt
import Core
import Combine
import Foundation
import web3swift

final class BalanceRepositoryImpl: BalanceRepository {
    @Published var balance: Value?
    var balancePublished: Published<Value?> { _balance }
    var balancePublisher: Published<Value?>.Publisher { $balance }
    
    private let address: Address
    private let network: Network
    private let web3: Web3
    private var cancellable: Cancellable?

    init(address: Address, network: Network) {
        self.address = address
        self.network = network
        let provider = Web3HttpProvider(
            url: network.rpcUrl,
            network: .Custom(networkID: BigUInt(network.chainId))
        )
        self.web3 = Web3(provider: provider)
        
        startPolling()
    }
    
    func startPolling() {
        cancellable = Timer.publish(every: 6, on: .main, in: .default)
            .autoconnect()
            .prepend(Date())
            .await { [weak self] _ -> Value? in
                guard let self = self else {
                    return nil
                }
                let value = try await self.web3.eth.getBalance(
                    for: self.address.address
                )
                return Value(value)
            }
            .receive(on: RunLoop.main)
            .sink { [weak self] value in
                self?.balance = value
            }
    }
}
