//
//  ArticleServiceSpec.swift
//  NYTimesAppTests
//
//  Created by Marutharaj Kuppusamy on 11/10/18.
//  Copyright © 2019 ta. All rights reserved.
//

import Foundation
import Quick
import Nimble
import OHHTTPStubs

@testable import NYTimesApp

class ArticleServiceSpec: QuickSpec {
    
    override func spec() {
        
        describe("The 'Article Service'") {
            
            context("Can be returned valid article JSON") {

                it("returns Article Data") {
                    var returnedArticleData: [Article]?
                    
                    stub(condition: isHost("api.nytimes.com") && isPath("/svc/mostpopular/v2/mostviewed/all-sections/30.json")) { _ in
                        return OHHTTPStubsResponse(
                            fileAtPath: OHPathForFile("article.json", type(of: self))!,
                            statusCode: 200,
                            headers: ["Content-Type": "application/json"]
                        )
                    }
                    
                    ArticleService().sendRequest(period: 30, completionHandler: { (articles) in
                        returnedArticleData = articles
                        expect(returnedArticleData).toNot(beNil())
                    })
                }
                
                it("returns error") {
                    var returnedError: Error?
                    
                    let error = NSError(domain: "Article service not found.", code: 404, userInfo: nil)
                    
                    stub(condition: isHost("api.nytimes.com") && isPath("/svc/mostpopular/v2/mostviewed/all-sections/30.json")) { _ in
                        return OHHTTPStubsResponse(error: error)
                    }
                    
                    let url = URL(string: "http://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/30.json?api-key=f672bdce0aa744e7867bf16d9642b53a")
                    
                    URLSession.shared.dataTask(with: url!) {(_, _, error ) in
                        returnedError = error
                        expect(returnedError).toNot(beNil())
                        expect(returnedError?.localizedDescription).to(equal("Article service not found."))
                    }
                }
            }
        }
    }
}
