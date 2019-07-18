//
//  Article.swift
//  NYTimesApp
//
//  Created by Apple on 7/18/19.
//  Copyright © 2019 ta. All rights reserved.
//

import Foundation

struct Article {
    
    private(set) var url: String?
    private(set) var adxKeywords: String?
    private(set) var column: String?
    private(set) var section: String?
    private(set) var byline: String?
    private(set) var type: String?
    private(set) var title: String?
    private(set) var abstract: String?
    private(set) var publishedDate: String?
    private(set) var source: String?
    private(set) var articleId: Int?
    private(set) var assetId: Int?
    private(set) var views: Int?
    private(set) var desFacet: [String]?
    private(set) var orgFacet: [String]?
    private(set) var perFacet: [String]?
    private(set) var geoFacet: [String]?
    private(set) var media: [Media] = []
}

extension Article: Parsable {
    
    mutating func parsing(_ parser: Parser) {
        url <-> parser["url"]
        adxKeywords <-> parser["adx_keywords"]
        column <-> parser["column"]
        section <-> parser["section"]
        byline <-> parser["byline"]
        type <-> parser["type"]
        title <-> parser["title"]
        abstract <-> parser["abstract"]
        publishedDate <-> parser["published_date"]
        source <-> parser["source"]
        articleId <-> parser["id"]
        assetId <-> parser["asset_id"]
        views <-> parser["views"]
        desFacet <-> parser["des_facet"]
        orgFacet <-> parser["org_facet"]
        perFacet <-> parser["per_facet"]
        geoFacet <-> parser["geo_facet"]
        media <-> parser["media"]
    }
}
