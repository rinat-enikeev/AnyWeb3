//
//  DI.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 16.12.2022.
//

import Factory

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
}
