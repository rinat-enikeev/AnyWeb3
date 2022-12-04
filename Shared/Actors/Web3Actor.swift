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
}
