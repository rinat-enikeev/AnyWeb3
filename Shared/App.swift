//
//  App.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 03.12.2022.
//

import Factory
import SwiftUI

@main
struct App: SwiftUI.App {
    @StateObject var model = AppModel()

    var body: some Scene {
        WindowGroup {
            VStack {
                if model.address == nil {
                    NavigationStack {
                        WelcomeView()
                    }
                } else {
                    if let network = model.network {
                        Text(network.name)
                    }
                    if let address = model.address {
                        Text(address, format: .shorten)
                    }
                    NavigationStack {
                        DashboardView()
                    }
                }
            }
        }
    }
}

class AppModel: ObservableObject {
    @Published var address: Address?
    @Published var network: Network?
    
    @Injected(Container.userRepository)
    private var userRepository
    @Injected(Container.settingsRepository)
    private var settingsRepository
    
    init() {
        userRepository.addressPublisher.assign(to: &$address)
        settingsRepository.networkPublisher.assign(to: &$network)
    }
}
