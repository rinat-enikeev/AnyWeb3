//
//  UserDefault.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 16.12.2022.
//

import Foundation

@propertyWrapper
public struct UserDefault<T: Codable> {
    let key: String
    let defaultValue: T? = nil
    let userDefaultsSuite : UserDefaults = UserDefaults.standard
    
    public var wrappedValue: T? {
        get {
            if let r = userDefaultsSuite.object(forKey: key) as? Data, let orgVal = try? JSONDecoder().decode(T.self, from: r) {
                return orgVal
            }
            else { return defaultValue }
        }
        set {
            if let n = newValue {
                let s = try! JSONEncoder().encode(n)
                userDefaultsSuite.set(s, forKey: key)
            }
            else {
                userDefaultsSuite.set(newValue, forKey: key)
            }
        }
    }
}
