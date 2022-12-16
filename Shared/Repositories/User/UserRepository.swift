//
//  UserRepository.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 16.12.2022.
//

import Foundation
import SwiftUI

protocol UserRepository {
    var account: Account? { get }
    var accountPublished: Published<Account?> { get }
    var accountPublisher: Published<Account?>.Publisher { get }
    func selectAccount(_ account: Account?)

    var address: Address? { get }
    var addressPublished: Published<Address?> { get }
    var addressPublisher: Published<Address?>.Publisher { get }
    func selectAddress(_ address: Address?)
}

extension UserRepository {
    var accountBinding: Binding<Account?> {
        Binding<Account?>(
            get: { account },
            set: { selectAccount($0) }
        )
    }
    
    var addressBinding: Binding<Address?> {
        Binding<Address?>(
            get: { address },
            set: { selectAddress($0) }
        )
    }
}
