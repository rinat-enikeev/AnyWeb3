//
//  AccountService.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 17.12.2022.
//

protocol AccountService {
    func createAccount() async throws
    #if DEBUG
    func createDemoAccount() async throws
    #endif
}
