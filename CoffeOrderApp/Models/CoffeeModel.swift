//
//  CoffeeModel.swift
//  CoffeOrderApp
//
//  Created by wonki on 2023/02/23.
//

import Foundation

@MainActor
class CoffeeModel: ObservableObject {
    let webservice: WebService
    @Published private(set) var orders: [Order] = []
    
    init(webservice: WebService) {
        self.webservice = webservice
    }
    
    func populateOrders() async throws {
        orders = try await webservice.getOrders()
        print(orders)
    }
    
    func placeOrder(_ order: Order) async throws {
        let newOrder = try await webservice.placeOrder(order: order)
        orders.append(newOrder)
    }
    
    func deleteOrder(_ orderId: Int) async throws {
        let deletedOrder = try await webservice.deleteOrder(orderId: orderId)
        orders = orders.filter { $0.id != deletedOrder.id }
    }
}
