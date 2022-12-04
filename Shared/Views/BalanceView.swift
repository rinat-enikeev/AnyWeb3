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
        if let value = balance?.value {
            Text(
                value,
                format: .crypto()
            )
        } else {
            ProgressView()
        }
    }
}
