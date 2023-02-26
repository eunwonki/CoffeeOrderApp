//
//  OrderDetailView.swift
//  CoffeOrderApp
//
//  Created by wonki on 2023/02/26.
//

import SwiftUI

struct OrderDetailView: View {
    // TODO: preview에서 update, delete가 동작하지 않음.
    
    let orderId: Int
    @EnvironmentObject private var model: CoffeeModel
    @State private var isPresented: Bool = false
    
    @Environment(\.dismiss) private var dismiss
    
    func deleteOrder() async {
        do {
            try await model.deleteOrder(orderId)
            dismiss()
        } catch {
            print(error)
        }
    }
    
    var body: some View {
        VStack {
            if let order = model.orderBy(id: orderId) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(order.coffeeName)
                        .font(.title)
                        .frame(width: .infinity,
                               alignment: .leading)
                        .accessibilityIdentifier("coffeeNameText")
                    Text(order.size.rawValue)
                        .opacity(0.5)
                    Text(order.total as NSNumber, formatter: NumberFormatter.currency)
                    
                    HStack {
                        Spacer()
                        Button("delete order", role: .destructive) {
                            Task {
                                await deleteOrder()
                            }
                        }
                        Button("edit order") {
                            isPresented = true
                        }
                        .accessibilityIdentifier("editOrderButton")
                        Spacer()
                    }
                }.sheet(isPresented: $isPresented) {
                    AddCoffeeView(original: order)
                }
            }
            Spacer()
        }
        .padding()
    }
}

struct OrderDetailView_Previews: PreviewProvider {
    static var previews: some View {
        OrderDetailView(orderId: 0)
            .environmentObject(
                CoffeeModel(webservice: MockingWebService()))
        // 왜 안뜨지??
    }
}
