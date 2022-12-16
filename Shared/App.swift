//
//  App.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 03.12.2022.
//

import SwiftUI

@main
struct App: SwiftUI.App {
    @StateObject var s = AppState()

    var body: some Scene {
        WindowGroup {
            VStack {
                Text(s.network?.name ?? "N/A")
                Text(s.address ?? .zero, format: .shorten)
                NavigationStack(path: $s.path) {
                    AddressView()
                        .environmentObject(s)
                }
            }
        }
    }
}
