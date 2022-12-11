//
//  Web3Actor.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 03.12.2022.
//

import BigInt
import Core
import Foundation
import web3swift

final actor Web3Actor {
    let web3: Web3
    let network: Network
    private let rpcUrl: URL
    
    init(_ network: Network) async {
        self.network = network
        self.rpcUrl = network.rpcUrl
        let provider = await Web3HttpProvider(
            rpcUrl,
            network: .Custom(networkID: BigUInt(network.chainId))
        )!
        self.web3 = Web3(provider: provider)
    }
    
    func sendTranscation(_ transaction: Transaction) async throws {
        var web3Tx = CodableTransaction(to: transaction.to.address)
        web3Tx.from = transaction.from.address
        web3Tx.value = transaction.value?.value ?? 0
        let resolver = PolicyResolver(provider: web3.provider)
        try await resolver.resolveAll(for: &web3Tx)
        let result = try await web3.eth.send(web3Tx)
    }
}
