//
//  AccountsRepository.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 11.12.2022.
//

import Combine
import Foundation

protocol AccountsRepository {
    var accounts: CurrentValueSubject<[Account], Never> { get }
    var lastUsedAccount: Account? { get }

    func storeAccount(_ account: Account)
}
