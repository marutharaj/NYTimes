//
//  NYTimesAppTests.swift
//  NYTimesAppTests
//
//  Created by Marutharaj Kuppusamy on 17/07/19.
//  Copyright © 2019 ta. All rights reserved.
//

import XCTest
@testable import NYTimesApp

class NYTimesAppTests: XCTestCase {
    var articleViewController: ArticleViewController?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        articleViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ArticleViewController") as? ArticleViewController
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceLoadArticleInTableView() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            if let path = Bundle(for: type(of: self)
                ).path(forResource: "article",
                       ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path),
                                        options: .alwaysMapped)
                    let decoder = JSONDecoder()
                    let articlesData = try decoder.decode(Articles.self, from: data)
                    _ = articleViewController?.view
                    articleViewController?.articles = articlesData.articles
                    articleViewController?.articleTableView.reloadData()
                } catch {
                    print("Problem parsing JSON")
                }
            }
        }
    }
}
