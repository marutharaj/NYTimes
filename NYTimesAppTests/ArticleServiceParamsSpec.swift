//
//  ArticleServiceParamsSpec.swift
//  NYTimesAppTests
//
//  Created by Apple on 7/18/19.
//  Copyright © 2019 ta. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import NYTimesApp

class ArticleServiceParamsSpec: QuickSpec {
    
    override func spec() {
        
        var subject: ArticleServiceParams!
        
        describe("Verify article service params") {
            
            context("When user select period as 1") {
                
                beforeEach {
                    subject = ArticleServiceParams(period: 1)
                }
                
                it("should get the correct article service params") {
                    
                    expect(subject.httpMethod == .GET) == true
                    expect(subject.path) == "1.json?api-key=\(ServiceConfiguration.apiKey)"
                }
            }
            
            context("When user select period as 7") {
                
                beforeEach {
                    subject = ArticleServiceParams(period: 7)
                }
                
                it("should get the correct article service params") {
                    
                    expect(subject.httpMethod == .GET) == true
                    expect(subject.path) == "7.json?api-key=\(ServiceConfiguration.apiKey)"
                }
            }
            
            context("When user select period as 30") {
                
                beforeEach {
                    subject = ArticleServiceParams(period: 30)
                }
                
                it("should get the correct article service params") {
                    
                    expect(subject.httpMethod == .GET) == true
                    expect(subject.path) == "30.json?api-key=\(ServiceConfiguration.apiKey)"
                }
            }
        }
    }
}
