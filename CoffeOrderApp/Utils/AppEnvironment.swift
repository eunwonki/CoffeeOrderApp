//
//  AppEnvironment.swift
//  CoffeOrderApp
//
//  Created by wonki on 2023/02/25.
//

import Foundation

struct Configuration {
    static var shared = Configuration()

    lazy var environment: AppEnvironment = {
        // read value from environment variable
        guard let env = ProcessInfo.processInfo.environment["ENV"] else {
            return AppEnvironment.dev
        }

        if env == "TEST" {
            return AppEnvironment.test
        }

        return AppEnvironment.dev
    }()
}

enum AppEnvironment: String {
    case dev
    case test
    // qa, release 등 여러 환경이 존재할수 있다.

    // TODO: preview에 사용할 MockingWebService는 따로 구현. (하지만 상속방식은 아직 고민 중...)

    var baseURL: URL {
        switch self {
        case .dev:
            return URL(string: "https://island-bramble.glitch.me")!
        case .test:
            return URL(string: "https://island-bramble.glitch.me")!
        }
    }
}
