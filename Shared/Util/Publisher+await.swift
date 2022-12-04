//
//  Publisher+await.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 04.12.2022.
//

import Combine
import Foundation

extension Publisher {
    func `await`<T>(_ transform: @escaping (Output) async throws -> T) -> AnyPublisher<T, Failure> {
        flatMap { value -> Future<T, Failure> in
            Future { promise in
                Task {
                    let result = try await transform(value)
                    promise(.success(result))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
