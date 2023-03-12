//
//  CoffeOrderAppApp.swift
//  CoffeOrderApp
//
//  Created by wonki on 2023/02/23.
//

import SwiftUI
import Moya

@main
struct CoffeOrderApp: App {
    @StateObject private var model: CoffeeModel

    init() {
        let provider = MoyaProvider<CoffeeAPI>()
        _model = StateObject(wrappedValue: CoffeeModel(provider: provider))
    }

    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(model)
        }
    }
}
