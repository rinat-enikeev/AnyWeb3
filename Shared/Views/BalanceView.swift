//
//  BalanceView.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 03.12.2022.
//

import Core
import SwiftUI

struct BalanceView: View {
    @EnvironmentObject var state: AppState
    @Binding var balance: Balance?

    var body: some View {
        Text(balance?.repository.balance.value.map(String.init) ?? "N/A")
    }
}
