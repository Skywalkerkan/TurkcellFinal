//
//  TurkcellFinalUITests.swift
//  TurkcellFinalUITests
//
//  Created by Erkan on 30.05.2024.
//

import XCTest

final class TurkcellFinalUITests: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_pages() {
         let tablesQuery = app.tables
         let byJohnIsmayAndDesireeRiosStaticText = tablesQuery.firstMatch
         byJohnIsmayAndDesireeRiosStaticText.tap()
    }
    
    func testKeyboardAndSearchButton(){
        let searchBarElement = app.otherElements["searchBar"]
        
        XCTAssertTrue(searchBarElement.waitForExistence(timeout: 10), "Search bar should exist")
        
        let searchButton = app.buttons["SearchButton"]
        let searchButtonFrameBefore = searchButton.frame
        
        searchBarElement.tap()
                
        let keyboard = app.keyboards.element
        XCTAssertTrue(keyboard.waitForExistence(timeout: 5), "The keyboard should appear")
        
        print(searchButtonFrameBefore.origin.y, searchButton.frame.origin.y)
        
        XCTAssertTrue(searchButtonFrameBefore.origin.y > searchButton.frame.origin.y, "The search button should move up when the keyboard appears")
    }
    
    
}
