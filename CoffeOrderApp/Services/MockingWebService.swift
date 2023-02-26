//
//  MockingWebService.swift
//  CoffeOrderApp
//
//  Created by wonki on 2023/02/25.
//

import Foundation

class MockingWebService: WebService {
    init() {
        super.init(baseURL: URL(string: "https://www.naver.com")!)
    }
    
    override func placeOrder(order: Order) async throws -> Order  {
        return order
    }
    
    override func getOrders() async throws -> [Order] {
        return [
            Order(name: "liam", coffeeName: "Americano",
                  total: 3.0, size: .small),
            Order(name: "robert", coffeeName: "Latte",
                  total: 5.0, size: .medium),
            Order(name: "pawn", coffeeName: "Vanila Latte",
                  total: 7.0, size: .large)
        ]
    }
}
