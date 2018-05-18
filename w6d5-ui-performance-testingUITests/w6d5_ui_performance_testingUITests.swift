//
//  w6d5_ui_performance_testingUITests.swift
//  w6d5-ui-performance-testingUITests
//
//  Created by Tyler Boudreau on 2018-05-18.
//  Copyright © 2018 Roland. All rights reserved.
//

import XCTest

class w6d5_ui_performance_testingUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    func deleteAllCells(){
        let tables = app.tables.cells
        while tables.count != 0{
            tables.element(boundBy: 0).swipeLeft()
            tables.element(boundBy: 0).buttons["Delete"].tap()
    }
}
    
    func checkMealDetails(checkMeal mealName:String, numberOfCalories:Int){
        app.tables.cells.staticTexts["\(mealName) - \(numberOfCalories)"].tap()
    }

    func deleteMeal(deleteMeal mealName:String, numberOfCalories:Int){
        let staticText = app.tables.staticTexts["\(mealName) - \(numberOfCalories)"]
        if staticText.exists {
            staticText.swipeLeft()
            app.tables.buttons["Delete"].tap()
        }
    }
    
    func addNewMeal(addMeal mealName:String, numberOfCalories:Int){
        app.navigationBars["Master"].buttons["Add"].tap()
        let addAMealAlert = app.alerts["Add a Meal"]
        let collectionViewsQuery = addAMealAlert.collectionViews
        collectionViewsQuery.children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .textField).element.typeText(mealName)
        
        let textField = collectionViewsQuery.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .textField).element
        textField.tap()
        textField.typeText(String(numberOfCalories))
        addAMealAlert.buttons["Ok"].tap()
        
     
    }

    override func setUp() {
        super.setUp()
        app.launch()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        deleteAllCells()
    }
    
    func testDeleteMeal(){
        deleteMeal(deleteMeal: "Burger", numberOfCalories: 300)
    }
    
    func testAddMeal() {
        
        addNewMeal(addMeal: "Burger", numberOfCalories: 300)
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testShowMealDetails(){
        checkMealDetails(checkMeal: "Burger", numberOfCalories: 300)
       XCTAssert(app.staticTexts["detailViewControllerLabel"].label == "Burger - 300", "Expected to be displaying Burger - 300")
        app.navigationBars["Detail"].buttons["Master"].tap()

    }
    
    func testDeleteAllMeals(){
        deleteAllCells()
       
    }
}
