//
//  TransactionView.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 25.12.2022.
//

import Factory
import Combine
import SwiftUI

struct TransactionView: View {
    @StateObject var model = TransactionModel()

    var body: some View {
        VStack {
            if let from = model.transaction.from {
                Text(from, format: .shorten)
                    .padding()
            } else {
                ProgressView()
            }
            TextField("To", value: $model.transaction.to, format: .address)
                .minimumScaleFactor(0.5)
                .padding()
            TextField("Value", value: $model.transaction.value, format: .fractional)
                .padding()
            HStack {
                Text("Gas limit")
                if let gasLimit = model.transaction.gasLimit {
                    Text(gasLimit, format: .fractional)
                } else {
                    ProgressView()
                }
            }
            .padding()
            HStack {
                Text("Gas price")
                if let gasPrice = model.transaction.gasPrice {
                    Text(gasPrice, format: .fractional)
                } else {
                    ProgressView()
                }
            }
            .padding()
        }
        .onChange(of: model.transaction) { _ in
            restartPolling()
        }
        .onChange(of: model.network) { _ in
            restartPolling()
        }
        .task {
            restartPolling()
        }
    }
    
    private func restartPolling() {
        model.restartPolling()
    }
}

final class TransactionModel: ObservableObject {
    @Injected(Container.userRepository)
    private var userRepository
    
    @Injected(Container.settingsRepository)
    private var settingsRepository

    @Published var transaction = Transaction()
    @Published var network: Network?

    private var cancellable: Cancellable?
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        userRepository.addressPublisher.sink { [weak self] from in
            self?.transaction.from = from
        }.store(in: &cancellables)
        settingsRepository.networkPublisher.assign(to: &$network)
    }
    
    func restartPolling() {
        cancellable?.cancel()
        guard let network else { return }
        let transactionActor = TransactionActor(network: network)
        cancellable = Timer.publish(every: .pollingInterval, on: .main, in: .default)
            .autoconnect()
            .prepend(Date())
            .await { [weak self] _ -> Transaction? in
                guard let self = self else {
                    return nil
                }
                return try await transactionActor.resolveTransaction(self.transaction)
            }
            .replaceNil(with: transaction)
            .receive(on: RunLoop.main)
            .sink { [weak self] transaction in
                self?.transaction = transaction
            }
    }
    
}

struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionView()
    }
}
