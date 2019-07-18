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
    
    func sendRequestSuccess(period: Int, completion: CompletionBlock) {
        let json = jsonDictionary(with: "article")
        let result = NYTimesResponse(json: json)
        completion?(true, result, "")
    }
    
    func sendRequestFailure(period: Int, completion: CompletionBlock) {
        let error = NYError.emptyData
        let result = NYTimesResponse(json: [:])
        completion?(false, result, error.localizedDescription)
    }
    
    override func spec() {
        
        describe("Verify article service") {
            
            context("When call article request") {
                
                it("server return success") {
                    self.sendRequestSuccess(period: 1) { success, result, errorCode in
                        expect(success).to(beTrue())
                        expect(result!.articles.isEmpty).to(beFalse())
                        expect(errorCode).to(beEmpty())
                    }
                }
                
                it("server return failure") {
                    self.sendRequestFailure(period: 1) { success, result, errorCode in
                        expect(success).to(beFalse())
                        expect(result!.articles.isEmpty).to(beTrue())
                        expect(errorCode).toNot(beNil())
                    }
                }
            }
        }
    }
}
