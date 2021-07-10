//
//  NewsDemoUITests.swift
//  NewsDemoUITests
//
//  Created by Anushree on 08/07/21.
//

import XCTest

@testable import NewsDemo

class NewsDemoUITests: XCTestCase {

    var app:XCUIApplication!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    /// test is country sheet apear on first load
    func testFastTimeUILoad(){
        let sheet = app.sheets["Country Selector"]
        //Test if sheet apears
        XCTAssertTrue(sheet.exists)
    }
    
    /// test is country sheet action on first load
    func testSheetActions(){
        let sheet = app.sheets["Country Selector"]
        let canadaButton = sheet.scrollViews.otherElements.buttons["Canada"]
        canadaButton.tap()
        XCTAssertFalse(sheet.exists)
    }
    
    /// test is country selection apears on right bar button
    func testNavigationTap(){
        let sheet = app.sheets["Country Selector"]
        let navBar = app.navigationBars["Canada News"].buttons["Compose"]
        navBar.tap()
        XCTAssertTrue(sheet.exists)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
