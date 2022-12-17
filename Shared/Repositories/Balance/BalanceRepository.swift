//
//  BalanceRepository.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 17.12.2022.
//

import Foundation

protocol BalanceRepository {
    var balance: Value? { get }
    var balancePublished: Published<Value?> { get }
    var balancePublisher: Published<Value?>.Publisher { get }
}
