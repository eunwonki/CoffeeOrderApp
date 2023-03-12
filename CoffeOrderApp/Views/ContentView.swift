//
//  ContentView.swift
//  CoffeOrderApp
//
//  Created by wonki on 2023/02/23.
//

import Foundation
import Moya
import SwiftUI

struct ContentView: View {
    @State private var isPresented: Bool = false
    @EnvironmentObject var model: CoffeeModel

    private func populateOrders() async {
        do {
            try await model.populateOrders()
        } catch {
            print(error)
        }
    }

    func deleteOrder(_ indexSet: IndexSet) {
        indexSet.forEach { index in
            let order = model.orders[index]
            guard let orderId = order.id else {
                return
            }

            // Moya의 Task와 SwiftUI의 Task가 겹쳐서 문제가 생김.
            _Concurrency.Task {
                do {
                    try await model.deleteOrder(orderId)
                } catch {
                    print(error)
                }
            }
        }
    }

    var body: some View {
        NavigationStack {
            VStack {
                if model.orders.isEmpty {
                    Text("No orders available!").accessibilityIdentifier("noOrdersText")
                } else {
                    List {
                        ForEach(model.orders) { order in
                            NavigationLink(value: order.id) {
                                OrderCellView(order: order)
                            }
                        }
                        .onDelete(perform: deleteOrder)
                    }.accessibilityIdentifier("orderList")
                }
            }
            .navigationDestination(for: Int.self, destination: {
                orderId in
                OrderDetailView(orderId: orderId)
            })
            .task {
                await populateOrders()
            }
            .sheet(isPresented: $isPresented) {
                AddCoffeeView()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add New Order") {
                        isPresented = true
                    }
                    .buttonStyle(.bordered)
                    .accessibilityIdentifier("addNewOrderButton")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(
            CoffeeModel(provider: MoyaProvider<CoffeeAPI>()))
    }
}
