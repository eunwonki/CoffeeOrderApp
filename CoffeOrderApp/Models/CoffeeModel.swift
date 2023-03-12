//
//  CoffeeModel.swift
//  CoffeOrderApp
//
//  Created by wonki on 2023/02/23.
//

import Foundation
import Moya

@MainActor
class CoffeeModel: ObservableObject {
    let provider: MoyaProvider<CoffeeAPI>
    
    @Published private(set) var orders: [Order] = []
    
    init(provider: MoyaProvider<CoffeeAPI>) {
        self.provider = provider
    }
    
    func orderBy(id: Int) -> Order? {
        guard let index = orders.firstIndex(where: { $0.id == id }) else {
            return nil
        }
        
        return orders[index]
    }
    
    func populateOrders() async throws {
        orders = try await provider.request(.allOrders)
    }
    
    func placeOrder(_ order: Order) async throws {
        let newOrder: Order = try await provider.request(.placeOrder(order))
        orders.append(newOrder)
    }
    
    func deleteOrder(_ orderId: Int) async throws {
        let deletedOrder: Order = try await provider.request(.deleteOrder(orderId))
        orders = orders.filter { $0.id != deletedOrder.id }
    }
    
    func updateOrder(_ order: Order) async throws {
        guard order.id != nil else { return }
        let updatedOrder: Order = try await provider.request(.updateOrder(order))
        guard let index = orders.firstIndex(where: { $0.id == updatedOrder.id }) else {
            throw CoffeeOrderError.invalidOrderId
        }
        orders[index] = updatedOrder
    }
}
