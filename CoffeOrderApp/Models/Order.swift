//
//  Order.swift
//  CoffeOrderApp
//
//  Created by wonki on 2023/02/23.
//

import Foundation

enum CoffeeOrderError: Error {
    case invalidOrderId
}

enum CoffeeSize: String, Codable, CaseIterable {
    case small = "Small"
    case medium = "Medium"
    case large = "Large"
}

struct Order: Codable, Identifiable, Hashable {
    // Codable에 의해 Json Parsign 실패하지 않도록 항상 주의하여 구현.
    var id: Int? // { return hashValue }

    var name: String
    var coffeeName: String
    var total: Double
    var size: CoffeeSize
}
