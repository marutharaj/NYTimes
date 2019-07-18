//
//  NYTimesResponseSpec.swift
//  NYTimesAppTests
//
//  Created by Marutharaj Kuppusamy on 18/07/19.
//  Copyright © 2019 ta. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import NYTimesApp

fileprivate extension String {
    
    var fileURL: URL {
        return URL(fileURLWithPath: self)
    }
}

func jsonDictionary(with file: String) -> [String: Any] {
    
    let bundle = Bundle(for: NYTimesResponseSpec.self)
    
    guard let fileURL = bundle.path(forResource: file, ofType: "json")?.fileURL,
        let data = try? Data(contentsOf: fileURL, options: []),
        let object = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
        let validObject = object as? JSON else {
            return [:]
    }
    
    return validObject
}

class NYTimesResponseSpec: QuickSpec {
    
    override func spec() {
        
        var subject: NYTimesResponse = NYTimesResponse(json: [:])

        describe("Verify article response parser") {

            context("When parsing article response") {
                
                beforeEach {
                    subject = NYTimesResponse(json: jsonDictionary(with: "article"))
                }
                
                it("should parse the correct status") {
                    expect(subject.status).to(equal("OK"))
                }
                
                it("should parse the correct copyright") {
                    expect(subject.copyright).to(equal("Copyright (c) 2019 The New York Times Company.  All Rights Reserved."))
                }
                
                it("should parse the correct number of results") {
                    expect(subject.numResults).to(equal(1922))
                }
                
                it("should parse the correct article") {
                    let article = subject.articles[0]
                    expect(article.title).to(equal("Live U.S. House Election Results"))
                    expect(article.byline).to(equal(""))
                    expect(article.publishedDate).to(equal("2019-11-06"))
                }
            }
        }
    }
}
