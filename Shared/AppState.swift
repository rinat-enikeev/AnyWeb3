//
//  AppState.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 04.12.2022.
//

import BigInt
import Core
import Combine
import Factory
import SwiftUI

class AppState: ObservableObject {
    @Published var path = NavigationPath()
    @Published var network: Network?
    @Published var account: Account?
    @Published var address: Address?
    @Published var transaction: Transaction = .zero
 
    @Injected(Container.userRepository)
    private var userRepository
    @Injected(Container.settingsRepository)
    private var settingsRepository
    
    init() {
        userRepository.accountPublisher.assign(to: &$account)
        userRepository.addressPublisher.assign(to: &$address)
        settingsRepository.networkPublisher.assign(to: &$network)
    }
}
