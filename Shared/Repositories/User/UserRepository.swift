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
    @MainActor func setAccount(_ account: Account?)

    var address: Address? { get }
    var addressPublished: Published<Address?> { get }
    var addressPublisher: Published<Address?>.Publisher { get }
    @MainActor func setAddress(_ address: Address?)
}

extension UserRepository {
    @MainActor
    var accountBinding: Binding<Account?> {
        Binding<Account?>(
            get: { account },
            set: { setAccount($0) }
        )
    }
    
    @MainActor
    var addressBinding: Binding<Address?> {
        Binding<Address?>(
            get: { address },
            set: { setAddress($0) }
        )
    }
}
