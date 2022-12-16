//
//  SettingsRepository.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 16.12.2022.
//

import Foundation
import SwiftUI

protocol SettingsRepository {
    var network: Network? { get }
    var networkPublished: Published<Network?> { get }
    var networkPublisher: Published<Network?>.Publisher { get }
    
    func selectNetwork(_ network: Network?)
}

extension SettingsRepository {
    var networkBinding: Binding<Network?> {
        Binding<Network?>(
            get: { network },
            set: { selectNetwork($0) }
        )
    }
}
