//
//  AppState.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 04.12.2022.
//

import BigInt
import Core
import Combine
import SwiftUI

class AppState: ObservableObject {
    @Published var path = NavigationPath()
    @Published var network: Network = .development
    @Published var address: Address = .zero
    @Published var transaction: Transaction = .zero
}
