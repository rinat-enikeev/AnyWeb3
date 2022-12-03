//
//  NetworkRepository.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 03.12.2022.
//

import BigInt
import Core
import Foundation
import web3swift

final actor NetworkRepository: ObservableObject {
    let web3: Web3
    private let rpcUrl: URL
    private let provider: Web3Provider
    
    init(_ network: Network) async {
        self.rpcUrl = network.rpcUrl
        self.provider = await Web3HttpProvider(
            rpcUrl,
            network: .Custom(networkID: BigUInt(network.chainId))
        )!
        self.web3 = Web3(provider: provider)
    }
}
