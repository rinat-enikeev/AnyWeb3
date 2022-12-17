//
//  UserRepositoryImpl.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 16.12.2022.
//

import Foundation

final class UserRepositoryImpl: UserRepository {
    @Published var account: Account?
    var accountPublisher: Published<Account?>.Publisher { $account }
    var accountPublished: Published<Account?> { _account }
    @UserDefault<Account>(key: "UserRepositoryImpl.account")
    var accountStorage: Account?
    
    @Published var address: Address?
    var addressPublisher: Published<Address?>.Publisher { $address }
    var addressPublished: Published<Address?> { _address }
    @UserDefault<Address>(key: "UserRepositoryImpl.address")
    var addressStorage: Address?
    
    init() {
        account = accountStorage
        address = addressStorage
    }
    
    func setAccount(_ account: Account?) {
        self.account = account
        self.accountStorage = account
    }
    
    func setAddress(_ address: Address?) {
        self.address = address
        self.addressStorage = address
    }
}
