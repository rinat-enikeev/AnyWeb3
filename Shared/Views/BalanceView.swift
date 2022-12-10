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
    @Binding var address: Address
    @Binding var network: Network
    @StateObject var model = BalanceModel()
    
    var body: some View {
        VStack {
            if let balance = model.balance {
                Text(balance, format: .crypto())
            } else {
                ProgressView()
            }
        }
        .onChange(of: network) { _ in
            restartPolling()
        }
        .onChange(of: address) { _ in
            restartPolling()
        }
        .task {
            restartPolling()
        }
    }
    
    private func restartPolling() {
        model.balance = nil
        model.address = address
        model.network = network
        Task {
            await model.startPolling()
        }
    }
}

final class BalanceModel: ObservableObject {
    @Published var balance: BigUInt?
    var address: Address = .zero
    var network: Network = .development
    private var balanceActor: BalanceActor?
    
    func startPolling() async {
        let web3 = await Web3Actor(network)
        let actor = BalanceActor(address: address, web3Actor: web3)
        actor.balance
            .receive(on: RunLoop.main)
            .assign(to: &$balance)
        actor.startPolling()
        balanceActor = actor
    }
}

//struct BalanceView_Previews: PreviewProvider {
//    static var previews: some View {
//        BalanceView(address: .preview, network: .development)
//    }
//}

