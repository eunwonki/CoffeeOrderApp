//
//  ContentView.swift
//  CoffeOrderApp
//
//  Created by wonki on 2023/02/23.
//

import SwiftUI

struct ContentView: View {
    @State private var isPresented: Bool = false
    @EnvironmentObject private var model: CoffeeModel

    private func populateOrders() async {
        do {
            try await model.populateOrders()
        } catch {
            print(error)
        }
    }

    var body: some View {
        NavigationStack {
            VStack {
                if model.orders.isEmpty {
                    Text("No orders available!").accessibilityIdentifier("noOrdersText")
                } else {
                    List(model.orders) { order in
                        OrderCellView(order: order)
                        // TODO: Actions 어떻게 호출하는겨...
                    }
                }
            }
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
        ContentView().environmentObject(CoffeeModel(webservice: MockingWebService()))
    }
}
