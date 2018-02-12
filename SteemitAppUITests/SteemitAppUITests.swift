//
//  SteemitAppUITests.swift
//  SteemitAppUITests
//
//  Created by Burak Tayfun on 2/12/18.
//  Copyright © 2018 Burak Tayfun. All rights reserved.
//

import XCTest

class SteemitAppUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()

        continueAfterFailure = false
        XCUIApplication().launch()

        addUIInterruptionMonitor(withDescription: "Push Dialog") { (alert) -> Bool in
            let button = alert.buttons["OK"]
            if button.exists {
                button.tap()
                return true
            }
            return false
        }
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExample() {
        
        let app = XCUIApplication()
        app.textFields["Please Enter Username"].typeText("th")
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.buttons["Search"].tap()
    }
    
}
