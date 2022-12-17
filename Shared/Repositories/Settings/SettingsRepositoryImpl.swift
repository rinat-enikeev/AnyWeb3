//
//  SettingsRepositoryImpl.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 16.12.2022.
//

import Foundation

final class SettingsRepositoryImpl: SettingsRepository {
    @Published var network: Network?
    var networkPublisher: Published<Network?>.Publisher { $network }
    var networkPublished: Published<Network?> { _network }
    @UserDefault<Network>(key: "SettingsRepositoryImpl.network")
    var networkStorage: Network?
    
    init() {
        #if DEBUG
        network = networkStorage ?? .development // by default
        #else
        network = networkStorage ?? .ethereum // by default
        #endif
    }
    
    func setNetwork(_ network: Network?) {
        self.network = network
        self.networkStorage = network
    }
}
