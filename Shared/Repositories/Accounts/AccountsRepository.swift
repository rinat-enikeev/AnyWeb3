//
//  AccountsRepository.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 11.12.2022.
//

import Combine
import Foundation

protocol AccountsRepository {
    var accounts: [Account] { get }
    var accountsPublished: Published<[Account]> { get }
    var accountsPublisher: Published<[Account]>.Publisher { get }
    func appendAccount(_ account: Account, keystore: Keystore)
    func obtainKeystore(for account: Account) async throws -> Keystore
}
