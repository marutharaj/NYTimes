//
//  NYTimesAppUITests.swift
//  NYTimesAppUITests
//
//  Created by Marutharaj Kuppusamy on 18/07/19.
//  Copyright © 2019 ta. All rights reserved.
//

import XCTest

class NYTimesAppUITests: XCTestCase {
    var sessionUnderTest: URLSession!
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sessionUnderTest = URLSession(configuration: URLSessionConfiguration.default)
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sessionUnderTest = nil
        super.tearDown()
    }
    
    // Test Article Service
    func testArticleService() {
        // given
        let methodName: String = "7.json"
        let queryString: String = "?api-key=LJiIOeA7ZGvTIeSFsP4AFXA78mhKob5X"
        let url = URL(string: "https://api.nytimes.com/svc/mostpopular/v2/viewed/" + methodName + queryString)
        
        let promise = expectation(description: "Status code: 200")
        
        var statusCode: Int?
        var responseError: Error?
        // when
        let dataTask = sessionUnderTest.dataTask(with: url!) { _, response, error in
            // then
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }
        dataTask.resume()
        waitForExpectations(timeout: 5, handler: nil)
        
        // then
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
    
    func testArticle() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let app = XCUIApplication()
        
        let navigationBar = app.navigationBars["articleNavigationBar"]
        XCTAssertTrue(navigationBar.waitForExistence(timeout: TimeInterval(20.0)), "Unable load article navigation bar")
        
        XCTAssertTrue(navigationBar.exists, "Article navigation bar does not exist")
        
        let navigationBarLeftButton = app.navigationBars["articleNavigationBar"].buttons["articleNavigationBarMenuButton"]
        XCTAssertTrue(navigationBarLeftButton.exists, "Article navigation bar menu button does not exist")
        
        let navigationBarSearchRightButton = app.navigationBars["articleNavigationBar"].buttons["articleNavigationBarSearchButton"]
        XCTAssertTrue(navigationBarSearchRightButton.exists, "Article navigation bar search button does not exist")
        
        let navigationBarMoreRightButton = app.navigationBars["articleNavigationBar"].buttons["articleNavigationBarMoreButton"]
        XCTAssertTrue(navigationBarMoreRightButton.exists, "Article navigation bar more button does not exist")
        
        let table = app.tables["articleTableView"]
        XCTAssertTrue(table.exists, "Article table does not exist")
    }
    
    func testArticleDetail() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let app = XCUIApplication()
        
        let articleNavigationBar = app.navigationBars["articleNavigationBar"]
        XCTAssertTrue(articleNavigationBar.waitForExistence(timeout: TimeInterval(20.0)), "Unable load article navigation bar")
        
        let table = app.tables["articleTableView"]
        let firstCell = table.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.waitForExistence(timeout: TimeInterval(20.0)), "Unable to load first cell")
        firstCell.tap()
        
        let navigationBar = app.navigationBars["articleDetailNavigationBar"]
        XCTAssertTrue(navigationBar.exists, "Article detail navigation bar does not exist")
        
        let navigationBarLeftButton = app.navigationBars["articleDetailNavigationBar"].buttons["articleDetailNavigationBarBackButton"]
        XCTAssertTrue(navigationBarLeftButton.exists, "Article detail navigation bar back button does not exist")
        
    }
}
