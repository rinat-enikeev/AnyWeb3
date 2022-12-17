//
//  AccountServiceImpl.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 17.12.2022.
//

import Factory
import Foundation

final class AccountServiceImpl: AccountService {
    enum Error: Swift.Error {
        case failedToGetFirstAddress
    }
    @Injected(Container.accountsRepository)
    private var accountsRepository
    @Injected(Container.userRepository)
    private var userRepository
    @Injected(Container.keystoreActor)
    private var keystoreActor
    
    func createAccount() async throws {
        let keystore = try await keystoreActor.generate(
            language: .spanish,
            password: ""
        )
        guard let firstAddress = keystore.addresses?.first else {
            throw Error.failedToGetFirstAddress
        }
        let account = Account(firstAddress: firstAddress)
        accountsRepository.appendAccount(account, keystore: keystore)
        await userRepository.setAccount(account)
        await userRepository.setAddress(keystore.addresses?.first)
    }
    #if DEBUG
    func createDemoAccount() async throws {
        let mnemonicsURL = Bundle.main.url(forResource: "mnemonics", withExtension: "")!
        let mnemonics = try String(contentsOf: mnemonicsURL)
        let keystore = try await keystoreActor.generate(
            mnemonics: mnemonics,
            language: .spanish,
            password: ""
        )
        guard let firstAddress = keystore.addresses?.first else {
            throw Error.failedToGetFirstAddress
        }
        let account = Account(firstAddress: firstAddress)
        accountsRepository.appendAccount(account, keystore: keystore)
        await userRepository.setAccount(account)
        await userRepository.setAddress(keystore.addresses?.first)
        
    }
    #endif
}
