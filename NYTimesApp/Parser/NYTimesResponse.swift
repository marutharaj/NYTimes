//
//  NYTimesResponse.swift
//  NYTimesApp
//
//  Created by Marutharaj Kuppusamy on 7/18/19.
//  Copyright © 2019 ta. All rights reserved.
//

import Foundation

struct NYTimesResponse: ParsableResult {
    
    private(set) var status: String?
    private(set) var copyright: String?
    private(set) var numResults: Int?
    private(set) var articles: [Article] = []
    
    mutating func parsing(_ parser: Parser) {
        status <-> parser["status"]
        copyright <-> parser["copyright"]
        numResults <-> parser["num_results"]
        articles <-> parser["results"]
    }
}
