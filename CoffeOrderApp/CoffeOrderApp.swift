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
        let webservice = WebService()
        _model = StateObject(wrappedValue: CoffeeModel(webservice: webservice))
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(model)
        }
    }
}
