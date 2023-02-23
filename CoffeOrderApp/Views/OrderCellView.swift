//
//  OrderCellView.swift
//  CoffeOrderApp
//
//  Created by wonki on 2023/02/23.
//

import Foundation
import SwiftUI

struct OrderCellView: View {
    let order: Order
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(order.name)
                    .accessibilityIdentifier("orderNameText")
                    .bold()
                Text("\(order.coffeeName) (\(order.size.rawValue))")
                    .accessibilityIdentifier("coffeeNameAndSizeText")
                    .opacity(0.5)
            }
            Spacer()
            Text(order.total as NSNumber, formatter: NumberFormatter.currency)
                .accessibilityIdentifier("coffeePriceText")
        }
        Text(order.name)
        
    }
}

struct OrderCellView_Previews: PreviewProvider {
    static var previews: some View {
        OrderCellView(order: Order(name: "1", coffeeName: "2", total: 1.0, size: .small))
    }
}
