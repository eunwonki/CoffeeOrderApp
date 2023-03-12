//
//  CoffeeAPI+Extension.swift
//  CoffeOrderApp
//
//  Created by wonki on 2023/03/12.
//

import Foundation

extension CoffeeAPI {
    var sampleData: Data {
        switch self {
        case .allOrders:
            // TODO: json 파일을 바이너리로 포함하는데 더 좋은 방법 있을까?
            // TODO: 실패했을 때를 Test할수 있는 방법도 있나?
            return try! Data(contentsOf: Bundle.main.url(
                forResource: "all_orders", withExtension: "json")!)
        case .placeOrder(let order):
            return Data(try! JSONEncoder().encode(order))
        case .deleteOrder(_):
            return Data()
        case .updateOrder(let order):
            return Data(try! JSONEncoder().encode(order))
        }
    }
}
