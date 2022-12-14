//
//  DI.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 16.12.2022.
//

import Factory

extension Container {
    static let balanceRepository = ParameterFactory<(Network, Address), BalanceRepository> { network, address in
        BalanceRepositoryImpl(address: address, network: network) as BalanceRepository
    }
}

extension Container {
    static let accountsRepository = Factory(scope: .shared) {
        AccountsRepositoryImpl() as AccountsRepository
    }
    
    static let userRepository = Factory(scope: .shared) {
        UserRepositoryImpl() as UserRepository
    }
    
    static let settingsRepository = Factory(scope: .shared) {
        SettingsRepositoryImpl() as SettingsRepository
    }
    
    static let keystoreActor = Factory(scope: .shared) {
        KeystoreActor()
    }
    
    static let accountService = Factory(scope: .shared) {
        AccountServiceImpl() as AccountService
    }
}
