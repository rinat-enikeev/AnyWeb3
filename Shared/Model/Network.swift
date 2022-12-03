//
//  Network.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 03.12.2022.
//

import Foundation

struct Network: Hashable, Identifiable {
    var id: String { name }
    var name: String
    var rpcUrl: URL
    var chainId: Int
}

extension Network {
    static var development: Self {
        Network(
            name: "Development",
            rpcUrl: URL(string: "http://127.0.0.1:8545")!,
            chainId: 100
        )
    }
    
    static var ethereum: Self {
        Network(
            name: "Ethereum",
            rpcUrl: URL(string: "https://rpc.ankr.com/eth")!,
            chainId: 1
        )
    }
    
    static var gnosis: Self {
        Network(
            name: "Gnosis",
            rpcUrl: URL(string: "https://rpc.gnosischain.com")!,
            chainId: 100
        )
    }
}
