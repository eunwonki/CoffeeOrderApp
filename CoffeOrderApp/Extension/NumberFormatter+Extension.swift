//
//  NumberFormatter+Extension.swift
//  CoffeOrderApp
//
//  Created by wonki on 2023/02/23.
//

import Foundation

extension NumberFormatter {
    static var currency: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }
}
