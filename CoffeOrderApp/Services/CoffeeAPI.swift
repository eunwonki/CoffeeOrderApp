//
//  CoffeeAPI.swift
//  CoffeOrderApp
//
//  Created by wonki on 2023/03/12.
//

import Foundation
import Moya

enum CoffeeAPI: TargetType {
    case allOrders
    case placeOrder(_ order: Order)
    case deleteOrder(_ id: Int)
    case updateOrder(_ order: Order)

    var baseURL: URL {
        Configuration.shared.environment.baseURL
    }

    var path: String {
        switch self {
        case .allOrders:
            return "test/orders"
        case .placeOrder:
            return "test/new-order"
        case .deleteOrder(let orderId):
            return "/test/orders/\(orderId)"
        case .updateOrder(let order):
            return "/test/orders/\(order.id!)" // 항상 실행하기 전 검사할 것.
        }
    }

    var method: Moya.Method {
        switch self {
        case .allOrders:
            return .get
        case .placeOrder:
            return .post
        case .deleteOrder:
            return .delete
        case .updateOrder:
            return .put
        }
    }

    var task: Moya.Task {
        switch self {
        case .allOrders:
            return .requestPlain
        case .placeOrder(let order):
            return .requestJSONEncodable(order)
        case .deleteOrder:
            return .requestPlain
        case .updateOrder(let order):
            return .requestJSONEncodable(order)
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}
