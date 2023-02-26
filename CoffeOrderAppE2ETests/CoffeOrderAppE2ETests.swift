//
//  CoffeOrderAppE2ETests.swift
//  CoffeOrderAppE2ETests
//
//  Created by wonki on 2023/02/25.
//

import XCTest

// TODO: update, delete test code가 실패함...

final class when_updating_an_existing_order: XCTestCase {
    private var app: XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication()
        continueAfterFailure = false
        app.launchEnvironment = ["ENV": "TEST"]
        app.launch()
        
        // go to place order screen
        app.buttons["addNewOrderButton"].tap()
        
        // fill out the textfields
        let nameTextField = app.textFields["name"]
        let coffeeNameTextField = app.textFields["coffeeName"]
        let priceTextField = app.textFields["price"]
        let placeOrderButton = app.buttons["placeOrderButton"]
        
        nameTextField.tap()
        nameTextField.typeText("John")
        
        coffeeNameTextField.tap()
        coffeeNameTextField.typeText("Hot Coffee")
        
        priceTextField.tap()
        priceTextField.typeText("4.50")
        
        // place ther order
        placeOrderButton.tap()
    }
    
    func test_should_update_order_successfully() {
        let orderList = app.collectionViews["orderList"]
        orderList.buttons["orderNameText-coffeeNameAndSizeText-coffeePriceText"].tap()
        
        app.buttons["editOrderButton"].tap()
        
        let nameTextField = app.textFields["name"]
        let coffeeNameTextField = app.textFields["coffeeName"]
        let priceTextField = app.textFields["price"]
        let placeOrderButton = app.buttons["placeOrderButton"]
        
        _ = nameTextField.waitForExistence(timeout: 2)
        nameTextField.tap(withNumberOfTaps: 2, numberOfTouches: 1)
        nameTextField.typeText("John Edit")
        
        _ = coffeeNameTextField.waitForExistence(timeout: 10)
        coffeeNameTextField.tap(withNumberOfTaps: 2, numberOfTouches: 1)
        coffeeNameTextField.typeText("Hot Coffee Edit")
        
        _ = priceTextField.waitForExistence(timeout: 2)
        priceTextField.tap(withNumberOfTaps: 2, numberOfTouches: 1)
        priceTextField.typeText("1.50")
        
        placeOrderButton.tap()
        
        XCTAssertEqual("Hot Coffee Edit", app.staticTexts["coffeeNameText"].label)
    }
    
    override func tearDown() {
        Task {
            guard let url = URL(string: "/test/clear-orders",
                                relativeTo: URL(string: "https://island-bramble.glitch.me")!)
            else {
                return
            }
            
            _ = try! await URLSession.shared.data(from: url)
        }
    }
}

final class when_deleting_an_order: XCTestCase {
    private var app: XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication()
        continueAfterFailure = false
        app.launchEnvironment = ["ENV": "TEST"]
        app.launch()
        
        // go to place order screen
        app.buttons["addNewOrderButton"].tap()
        
        // fill out the textfields
        let nameTextField = app.textFields["name"]
        let coffeeNameTextField = app.textFields["coffeeName"]
        let priceTextField = app.textFields["price"]
        let placeOrderButton = app.buttons["placeOrderButton"]
        
        nameTextField.tap()
        nameTextField.typeText("John")
        
        coffeeNameTextField.tap()
        coffeeNameTextField.typeText("Hot Coffee")
         
        priceTextField.tap()
        priceTextField.typeText("4.50")
        
        // place ther order
        placeOrderButton.tap()
    }
    
    func test_should_delete_order_successsfully() {
        let orderList = app.collectionViews["orderList"]
//        XCTAssertEqual(1, orderList.cells.count)
        
        let collectionViewsQuery = XCUIApplication().collectionViews
        let cellsQuery = collectionViewsQuery.cells
        let element = cellsQuery.children(matching: .other).element(boundBy: 1).children(matching: .other).element
        element.swipeLeft() // TODO: 동작하지 않음...
        collectionViewsQuery.buttons["Delete"].tap()
        
        XCTAssertEqual(0, orderList.cells.count)
    }
    
    override func tearDown() {
        Task {
            guard let url = URL(string: "/test/clear-orders",
                                relativeTo: URL(string: "https://island-bramble.glitch.me")!)
            else {
                return
            }
            
            _ = try! await URLSession.shared.data(from: url)
        }
    }
}

final class when_adding_a_new_coffee_order: XCTestCase {
    private var app: XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication()
        continueAfterFailure = false
        app.launchEnvironment = ["ENV": "TEST"]
        app.launch()
        
        // go to place order screen
        app.buttons["addNewOrderButton"].tap()
        
        // fill out the textfields
        let nameTextField = app.textFields["name"]
        let coffeeNameTextField = app.textFields["coffeeName"]
        let priceTextField = app.textFields["price"]
        let placeOrderButton = app.buttons["placeOrderButton"]
        
        nameTextField.tap()
        nameTextField.typeText("John")
        
        coffeeNameTextField.tap()
        coffeeNameTextField.typeText("Hot Coffee")
         
        priceTextField.tap()
        priceTextField.typeText("4.50")
        
        placeOrderButton.tap()
    }
    
    func test_should_display_coffee_order_in_list_successfully() throws {
        XCTAssertEqual("John", app.staticTexts["orderNameText"].label)
        XCTAssertEqual("Hot Coffee (Medium)", app.staticTexts["coffeeNameAndSizeText"].label)
        XCTAssertEqual("$4.50", app.staticTexts["coffeePriceText"].label)
    }
    
    override func tearDown() {
        // TODO: Web Server의 종속성을 갖는 이 Test 구조가 맞나?
        Task {
            guard let url = URL(string: "/test/clear-orders",
                                relativeTo: URL(string: "https://island-bramble.glitch.me")!)
            else {
                return
            }
            
            _ = try! await URLSession.shared.data(from: url)
        }
    }
}

final class when_app_is_launched_with_no_orders: XCTestCase {
    func test_should_make_sure_no_orders_meesage_is_displayed() {
        let app = XCUIApplication()
        continueAfterFailure = false
        app.launchEnvironment = ["ENV": "TEST"]
        app.launch()
        
        XCTAssertEqual("No orders available!", app.staticTexts["noOrdersText"].label)
    }
}
