//
//  CoffeOrderAppApp.swift
//  CoffeOrderApp
//
//  Created by wonki on 2023/02/23.
//

import SwiftUI

@main
struct CoffeOrderApp: App {
    @StateObject private var model: CoffeeModel

    init() {
        var config = Configuration()
        let webservice = WebService(baseURL: config.environment.baseURL)
        _model = StateObject(wrappedValue: CoffeeModel(webservice: webservice))
    }

    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(model)
        }
    }
}
