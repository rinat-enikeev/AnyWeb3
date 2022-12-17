//
//  WelcomeView.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 17.12.2022.
//

import Factory
import SwiftUI

enum WelcomeState {
    case idle
    case loading
    case error
}

struct WelcomeView: View {
    private let appName = Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String
    @Injected(Container.accountService)
    private var accountService
    @State private var state: WelcomeState = .idle

    var body: some View {
        VStack {
            switch state {
            case .idle:
                Spacer()
                #if DEBUG
                Button("Use demo wallet") {
                    state = .loading
                    Task {
                        do {
                            try await accountService.createDemoAccount()
                        } catch {
                            await MainActor.run {
                                state = .error
                            }
                        }
                    }
                }
                #endif
                Button("Create new wallet") {
                    state = .loading
                    Task {
                        do {
                            try await accountService.createAccount()
                        } catch {
                            await MainActor.run {
                                state = .error
                            }
                        }
                    }
                }
                .buttonStyle(.bordered)
                .padding()
            case .loading:
                ProgressView()
            case .error:
                Text("Error")
                Button("OK") {
                    state = .idle
                }
            }
        }
        .navigationTitle("\(appName ?? "App")")
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
