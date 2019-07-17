//
//  ArticleSpec.swift
//  NYTimesAppTests
//
//  Created by Marutharaj Kuppusamy on 11/10/18.
//  Copyright © 2019 ta. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import NYTimesApp

class ArticleSpec: QuickSpec {
    
    override func spec() {
        var articles: Articles?

        describe("The 'Article'") {

            context("Can be created with valid JSON") {
                
                afterEach {
                    articles = nil
                }
                
                beforeEach {
                    
                    if let path = Bundle(for: type(of: self)
                        ).path(forResource: "article",
                               ofType: "json") {
                        do {
                            let data = try Data(contentsOf: URL(fileURLWithPath: path),
                                                options: .alwaysMapped)
                            let decoder = JSONDecoder()
                            articles = try decoder.decode(Articles.self, from: data)
                        } catch {
                            fail("Problem parsing JSON")
                        }
                    }
                }
                it("can parse the correct status") {
                    expect(articles?.status).to(equal("OK"))
                }
                it("can parse the correct copyright") {
                    expect(articles?.copyright).to(equal("Copyright (c) 2019 The New York Times Company.  All Rights Reserved."))
                }
                it("can parse the correct number of results") {
                    expect(articles?.numResults).to(equal(1922))
                }
                it("can parse the correct article") {
                    let article = articles?.articles[0]
                    expect(article?.title).to(equal("Live U.S. House Election Results"))
                    expect(article?.byline).to(equal(""))
                    expect(article?.publishedDate).to(equal("2019-11-06"))
                }
            }
        }
    }
}
