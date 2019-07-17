//
//  Article.swift
//  NYTimesApp
//
//  Created by Marutharaj Kuppusamy on 17/07/19.
//  Copyright © 2019 ta. All rights reserved.
//

import Foundation

struct MediaMetaData: Codable {
    let url: String?
    let format: String?
    let height: Int?
    let width: Int?
    
    private enum CodingKeys: String, CodingKey {
        case url
        case format
        case height
        case width
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        url = try? values.decode(String.self, forKey: .url)
        format = try? values.decode(String.self, forKey: .format)
        height = try? values.decode(Int.self, forKey: .height)
        width = try? values.decode(Int.self, forKey: .width)
    }
}

struct Media: Codable {
    let type: String?
    let subtype: String?
    let caption: String?
    let copyright: String?
    let approvedForSyndication: Int?
    let mediaMetaData: [MediaMetaData]
    
    private enum CodingKeys: String, CodingKey {
        case type
        case subtype
        case caption
        case copyright
        case approvedForSyndication = "approved_for_syndication"
        case mediaMetaData = "media-metadata"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        type = try? values.decode(String.self, forKey: .type)
        subtype = try? values.decode(String.self, forKey: .subtype)
        caption = try? values.decode(String.self, forKey: .caption)
        copyright = try? values.decode(String.self, forKey: .copyright)
        approvedForSyndication = try? values.decode(Int.self, forKey: .approvedForSyndication)
        
        if let decodedMediaMetaData = try? values.decode([MediaMetaData].self, forKey: .mediaMetaData) {
            mediaMetaData = decodedMediaMetaData
        } else {
            mediaMetaData = []
        }
    }
}

struct Article: Codable {
    let url: String?
    let adxKeywords: String?
    let column: String?
    let section: String?
    let byline: String?
    let type: String?
    let title: String?
    let abstract: String?
    let publishedDate: String?
    let source: String?
    let articleId: Int?
    let assetId: Int?
    let views: Int?
    let desFacet: [String]?
    let orgFacet: [String]?
    let perFacet: [String]?
    let geoFacet: [String]?
    let media: [Media]
    
    private enum CodingKeys: String, CodingKey {
        case url
        case adxKeywords = "adx_keywords"
        case column
        case section
        case byline
        case type
        case title
        case abstract
        case publishedDate = "published_date"
        case source
        case articleId = "id"
        case assetId = "asset_id"
        case views
        case desFacet = "des_facet"
        case orgFacet = "org_facet"
        case perFacet = "per_facet"
        case geoFacet = "geo_facet"
        case media
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        url = try? values.decode(String.self, forKey: .url)
        adxKeywords = try? values.decode(String.self, forKey: .adxKeywords)
        column = try? values.decode(String.self, forKey: .column)
        section = try? values.decode(String.self, forKey: .section)
        byline = try? values.decode(String.self, forKey: .byline)
        type = try? values.decode(String.self, forKey: .type)
        title = try? values.decode(String.self, forKey: .title)
        abstract = try? values.decode(String.self, forKey: .abstract)
        publishedDate = try? values.decode(String.self, forKey: .publishedDate)
        source = try? values.decode(String.self, forKey: .source)
        articleId = try? values.decode(Int.self, forKey: .articleId)
        assetId = try? values.decode(Int.self, forKey: .assetId)
        views = try? values.decode(Int.self, forKey: .views)
        
        if let decodedDesFacet = try? values.decode([String].self, forKey: .desFacet) {
            desFacet = decodedDesFacet
        } else {
            desFacet = []
        }
        
        if let decodedOrgFacet = try? values.decode([String].self, forKey: .orgFacet) {
            orgFacet = decodedOrgFacet
        } else {
            orgFacet = []
        }
        
        if let decodedPerFacet = try? values.decode([String].self, forKey: .perFacet) {
            perFacet = decodedPerFacet
        } else {
            perFacet = []
        }
        
        if let decodedGeoFacet = try? values.decode([String].self, forKey: .geoFacet) {
            geoFacet = decodedGeoFacet
        } else {
            geoFacet = []
        }
        
        if let decodedMedia = try? values.decode([Media].self, forKey: .media) {
            media = decodedMedia
        } else {
            media = []
        }
    }
}

struct Articles: Codable {
    let status: String?
    let copyright: String?
    let numResults: Int?
    let articles: [Article]
    
    private enum CodingKeys: String, CodingKey {
        case status
        case copyright
        case numResults = "num_results"
        case articles = "results"
    }
}
