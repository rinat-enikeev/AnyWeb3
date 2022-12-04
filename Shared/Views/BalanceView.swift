//
//  BalanceView.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 03.12.2022.
//

import BigInt
import Core
import SwiftUI

struct BalanceView: View {
    @EnvironmentObject var state: AppState
    @Binding var balance: Balance?

    var body: some View {
        if let balance, let value = balance.repository.balance.value {
            Text(
                value,
                format: .crypto(
                    decimals: balance.repository.connection.repository.network.decimals
                )
            )
        } else {
            ProgressView()
        }
    }
}
