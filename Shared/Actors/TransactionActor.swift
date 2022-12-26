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
        var codable = CodableTransaction(from: transaction)
        try await policy.resolveAll(for: &codable, with: .auto)
        return Transaction(from: codable)
    }
    
    func signTransaction(_ transaction: Transaction, address: Address, keystore: Keystore) throws -> Transaction {
        var codable = CodableTransaction(from: transaction)
        try Web3Signer.signTX(
            transaction: &codable,
            keystore: keystore.web3,
            account: address.address,
            password: ""
        )
        return Transaction(from: codable)
    }
    
    func sendTransaction(_ transaction: Transaction) async throws {
        let result = try await web3.eth.send(CodableTransaction(from: transaction))
        print(result)
    }
}

private extension Transaction {
    init(from codable: CodableTransaction) {
        self.init(
            from: codable.from.map(Address.init),
            to: Address(address: codable.to),
            value: Value(codable.value),
            gasLimit: Value(codable.gasLimit),
            gasPrice: codable.gasPrice.map(Value.init),
            nonce: codable.nonce,
            chainId: codable.chainID ?? 0,
            data: codable.data,
            v: codable.v,
            r: codable.r,
            s: codable.s
        )
    }
}

private extension CodableTransaction {
    init(from domain: Transaction) {
        self.init(
            type: .legacy,
            to: domain.to?.address ?? .zero,
            nonce: domain.nonce,
            chainID: domain.chainId,
            value: domain.value?.value ?? 0,
            data: domain.data,
            gasLimit: domain.gasLimit?.value ?? 0,
            gasPrice: domain.gasPrice?.value,
            v: domain.v,
            r: domain.r,
            s: domain.s
        )
        self.from = domain.from?.address
    }
}
