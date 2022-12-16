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
    func addAccount(_ account: Account)
}
