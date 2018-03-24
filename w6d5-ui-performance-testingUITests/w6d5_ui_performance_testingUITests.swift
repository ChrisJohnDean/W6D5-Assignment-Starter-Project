//
//  w6d5_ui_performance_testingUITests.swift
//  w6d5-ui-performance-testingUITests
//
//  Created by Chris Dean on 2018-03-23.
//  Copyright © 2018 Roland. All rights reserved.
//

import XCTest

class w6d5_ui_performance_testingUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
        app = XCUIApplication()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func addNewMeal(mealName: String, numberOfcalories: Int) {
        app.navigationBars["Master"].buttons["Add"].tap()
        
        let addAMealAlert = app.alerts["Add a Meal"]
        let collectionViewsQuery = addAMealAlert.collectionViews
        collectionViewsQuery.children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .textField).element.typeText(mealName)
        
        let textField = collectionViewsQuery.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .textField).element
        textField.tap()
        textField.typeText(String(numberOfcalories))
        addAMealAlert.buttons["Ok"].tap()
    }
    
    func deleteMeal(mealName: String, numberOfcalories: Int) {
        let staticText = app.tables.staticTexts["\(mealName) - \(numberOfcalories)"]
        if staticText.exists {
            staticText.swipeLeft()
            app.tables.buttons["Delete"].tap()
        }
    }
    
    func showMealDetail(mealName: String, numberOfcalories: Int) {
        app.tables.staticTexts["\(mealName) - \(numberOfcalories)"].tap()
    }
    
    func testAddMeal() {
        // Use recording to get started writing UI tests.
        self.measure {
            addNewMeal(mealName: "Burger", numberOfcalories: 300)
        }
        
        let that = app.tables.staticTexts["Burger - 300"]
        XCTAssert(that.exists)

    }
    
    func testDetailMeal() {
        deleteMeal(mealName: "Burger", numberOfcalories: 300)
        let that = app.tables.staticTexts["Burger - 300"]
        XCTAssertFalse(that.exists)

    }
    
    func testShowMealDetail() {
        showMealDetail(mealName: "Burger", numberOfcalories: 300)
        let thisElem: XCUIElement = app.staticTexts["detailViewControllerLabel"]
        XCTAssertEqual(thisElem.label, "Burger - 300")
        app.navigationBars["Detail"].buttons["Master"].tap()
        
    }
}









