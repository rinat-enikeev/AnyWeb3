//
//  Language.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 17.12.2022.
//

import Core
import Foundation

enum Language {
    case english
    case chineseSimplified
    case chineseTraditional
    case japanese
    case korean
    case french
    case italian
    case spanish
}

extension Language {
    var web3: BIP39Language {
        switch self {
        case .english:
            return .english
        case .chineseSimplified:
            return .chinese_simplified
        case .chineseTraditional:
            return .chinese_traditional
        case .japanese:
            return .japanese
        case .korean:
            return .korean
        case .french:
            return .french
        case .italian:
            return .italian
        case .spanish:
            return .spanish
        }
    }
}
