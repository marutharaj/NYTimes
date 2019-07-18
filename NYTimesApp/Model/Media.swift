//
//  Media.swift
//  NYTimesApp
//
//  Created by Apple on 7/18/19.
//  Copyright © 2019 ta. All rights reserved.
//

import Foundation

struct Media {
    
    private(set) var type: String?
    private(set) var subtype: String?
    private(set) var caption: String?
    private(set) var copyright: String?
    private(set) var approvedForSyndication: Int?
    private(set) var mediaMetaData: [MediaMetaData] = []
}

extension Media: Parsable {
    
    mutating func parsing(_ parser: Parser) {
        type <-> parser["type"]
        subtype <-> parser["subtype"]
        caption <-> parser["caption"]
        copyright <-> parser["copyright"]
        approvedForSyndication <-> parser["approved_for_syndication"]
        mediaMetaData <-> parser["media-metadata"]
    }
}
