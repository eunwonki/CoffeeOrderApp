//
//  AddCoffeeView.swift
//  CoffeOrderApp
//
//  Created by wonki on 2023/02/25.
//

import SwiftUI

struct AddCoffeeErrors {
    var name: String = ""
    var coffeeName: String = ""
    var price: String = ""
}

struct AddCoffeeView: View {
    var original: Order?
    
    @State private var name: String = ""
    @State private var coffeeName: String = ""
    @State private var price: String = ""
    @State private var coffeeSize: CoffeeSize = .medium
    
    @State private var errors = AddCoffeeErrors()
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var model: CoffeeModel
    
    var isValid: Bool {
        errors = AddCoffeeErrors()
        
        // this is nor a business rule
        // this is just ui validation
        if name.isEmpty {
            errors.name = "Name cannot be empty!"
        }
        
        if coffeeName.isEmpty {
            errors.coffeeName = "Coffee name cannot be empty"
        }
        
        if price.isEmpty {
            errors.price = "Price cannot be empty"
        } else if !price.isNumeric {
            errors.price = "Price needs to be a number"
        } else if price.isLessThan(1) {
            errors.price = "Price needs to be more than 0"
        }
        
        return errors.name.isEmpty && errors.price.isEmpty && errors.coffeeName.isEmpty
    }
    
    private func place(order: Order) async {
        do {
            try await model.placeOrder(order)
        } catch {
            print(error)
        }
    }
    
    private func update(order: Order) async {
        do {
            try await model.updateOrder(order)
        } catch {
            print(error)
        }
    }
    
    private func populateExistingOrder() {
        if let original {
            name = original.name
            coffeeName = original.coffeeName
            price = String(original.total)
            coffeeSize = original.size
        }
    }
    
    private func saveOrUpdate() async {
        let order = Order(
            id: original?.id,
            name: name, coffeeName: coffeeName,
            total: Double(price) ?? 0, size: coffeeSize)
        
        if original != nil {
            await update(order: order)
        } else {
            await place(order: order)
        }
        
        dismiss()
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                    .accessibilityIdentifier("name")
                Text(errors.name).visible(errors.name.isNotEmpty)
                    .font(.caption)
                
                TextField("Coffee name", text: $coffeeName)
                    .accessibilityIdentifier("coffeeName")
                Text(errors.coffeeName).visible(errors.coffeeName.isNotEmpty)
                    .font(.caption)
                
                TextField("Price", text: $price)
                    .accessibilityIdentifier("price")
                Text(errors.price).visible(errors.price.isNotEmpty)
                    .font(.caption)
                
                Picker("Select size", selection: $coffeeSize) {
                    ForEach(CoffeeSize.allCases, id: \.rawValue) { size in
                        Text(size.rawValue)
                            .tag(size) // this value will be binding to variable $coffeeSize
                    }
                }.pickerStyle(.segmented)
                
                Button(original != nil ? "Update Order" : "Place Order") {
                    if isValid {
                        Task {
                            await saveOrUpdate()
                        }
                    }
                }
                .centerHorizontally()
                .buttonStyle(.bordered)
                .accessibilityIdentifier("placeOrderButton")
            }.navigationTitle(original == nil ? "Add Order" : "Update Order")
        }.onAppear {
            populateExistingOrder()
        }
    }
}

struct AddCoffeeView_Previews: PreviewProvider {
    static var previews: some View {
        AddCoffeeView()
    }
}
