//
//  GlitchWebService.swift
//  CoffeOrderApp
//
//  Created by wonki on 2023/02/25.
//

import Foundation

class WebService {
    private var baseURL: URL
    
    init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    func updateOrder(_ order: Order) async throws -> Order {
        guard let orderId = order.id else {
            throw NetworkError.badUrl
        }
        
        guard let url = URL(string: EndPoint.updateOrder(orderId).path,
                            relativeTo: baseURL)
        else {
            throw NetworkError.badUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(order)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200
        else {
            throw NetworkError.badRequest(url: request.url,
                                          method: request.httpMethod)
        }
        
        guard let updatedOrder = try? JSONDecoder().decode(Order.self, from: data) else {
            throw NetworkError.decodingError(data: data)
        }
        
        return updatedOrder
    }
    
    func deleteOrder(orderId: Int) async throws -> Order {
        guard let url = URL(string: EndPoint.deleteOrder(orderId).path,
                            relativeTo: baseURL)
        else {
            throw NetworkError.badUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200
        else {
            throw NetworkError.badRequest(url: request.url,
                                          method: request.httpMethod)
        }
        
        guard let deletedOrder = try? JSONDecoder().decode(Order.self, from: data) else {
            throw NetworkError.decodingError(data: data)
        }
        
        return deletedOrder
    }
    
    func placeOrder(order: Order) async throws -> Order {
        guard let url = URL(string: EndPoint.placeOrder.path,
                            relativeTo: baseURL)
        else {
            throw NetworkError.badUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(order)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200
        else {
            throw NetworkError.badRequest(url: request.url,
                                          method: request.httpMethod)
        }
        
        guard let newOrder = try? JSONDecoder().decode(Order.self, from: data) else {
            throw NetworkError.decodingError(data: data)
        }
        
        return newOrder
    }
    
    func getOrders() async throws -> [Order] {
        guard let url = URL(string: EndPoint.allOrders.path,
                            relativeTo: baseURL)
        else {
            throw NetworkError.badUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200
        else {
            throw NetworkError.badRequest(url: url, method: "GET")
        }
        
        guard let orders = try? JSONDecoder().decode([Order].self, from: data) else {
            throw NetworkError.decodingError(data: data)
        }
        
        return orders
    }
}
