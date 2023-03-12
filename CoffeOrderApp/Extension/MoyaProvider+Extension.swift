//
//  MoyaProvider+Extension.swift
//  CoffeOrderApp
//
//  Created by wonki on 2023/03/12.
//

import Moya

extension MoyaProvider {
    func request<T: Decodable>(_ target: Target) async throws -> T {
        let response = try await withCheckedThrowingContinuation { continuation in
            self.request(target) { result in
                switch result {
                case .success(let response):
                    continuation.resume(returning: response)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }

        return try response.map(T.self)
    }
}
