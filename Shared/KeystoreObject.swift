//
//  KeystoresObject.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 03.12.2022.
//

import Core
import Foundation
import web3swift

@MainActor
final class KeystoreObject: ObservableObject {
    @Published var addresses: [EthereumAddress] = []
    private let repository = KeystoreRepository()
    
    init() {
        #if DEBUG
        Task {
            try await repository.loadDevelopmentAccount()
        }
        #endif
        repository.addresses
            .receive(on: RunLoop.main)
            .assign(to: &$addresses)
    }
}
