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
    }
    
}
