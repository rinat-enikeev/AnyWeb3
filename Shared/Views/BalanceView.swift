//
//  BalanceView.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 03.12.2022.
//

import BigInt
import Factory
import SwiftUI

struct BalanceView: View {
    @StateObject var model = BalanceModel()
    
    var body: some View {
        VStack {
            if let balance = model.balance {
                Text(balance, format: .fractional)
            } else {
                ProgressView()
            }
        }
        .onChange(of: model.network) { _ in
            restartPolling()
        }
        .onChange(of: model.address) { _ in
            restartPolling()
        }
        .task {
            restartPolling()
        }
    }
    
    private func restartPolling() {
        model.balance = nil
        model.startPolling()
    }
}

final class BalanceModel: ObservableObject {
    @Published var balance: Value?
    @Published var address: Address?
    @Published var network: Network?

    @Injected(Container.userRepository)
    private var userRepository
    @Injected(Container.settingsRepository)
    private var settingsRepository
    
    private var balanceRepository: BalanceRepository?
    
    init() {
        userRepository.addressPublisher.assign(to: &$address)
        settingsRepository.networkPublisher.assign(to: &$network)
    }
    
    func startPolling() {
        guard let network, let address else { return }
        let repository = Container.balanceRepository((network, address))
        repository
            .balancePublisher
            .receive(on: RunLoop.main)
            .assign(to: &$balance)
        balanceRepository = repository
    }
}

#if DEBUG
struct BalanceView_Previews: PreviewProvider {
    static var previews: some View {
        BalanceView_PreviewContainer()
    }
}

struct BalanceView_PreviewContainer : View {
    @State var address: Address? = .zero
    @State var network: Network? = .development

     var body: some View {
         BalanceView()
     }
}
#endif

