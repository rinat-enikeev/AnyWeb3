//
//  TransactionActor.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 25.12.2022.
//

import BigInt
import Foundation
import Web3Core
import web3swift

final actor TransactionActor {
    private let network: Network
    private let web3: Web3
    private let policy: PolicyResolver

    init(network: Network) {
        self.network = network
        let provider = Web3HttpProvider(
            url: network.rpcUrl,
            network: .Custom(networkID: BigUInt(network.chainId))
        )
        self.web3 = Web3(provider: provider)
        self.policy = PolicyResolver(provider: provider)
    }

    func resolveTransaction(_ transaction: Transaction) async throws -> Transaction {
        var codable: CodableTransaction = .emptyTransaction
        codable.from = transaction.from?.address
        codable.to = transaction.to?.address ?? .zero
        codable.value = transaction.value?.value ?? 0
        try await policy.resolveAll(for: &codable, with: .auto)
        return Transaction(
            from: transaction.from,
            to: transaction.to,
            value: transaction.value,
            gasLimit: Value(codable.gasLimit),
            gasPrice: codable.gasPrice.map(Value.init)
        )
    }
}
