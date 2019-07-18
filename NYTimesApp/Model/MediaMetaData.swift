//
//  MediaMetaData.swift
//  NYTimesApp
//
//  Created by Apple on 7/18/19.
//  Copyright © 2019 ta. All rights reserved.
//

import Foundation

struct MediaMetaData {
    
    private(set) var url: String?
    private(set) var format: String?
    private(set) var height: Int?
    private(set) var width: Int?
}

extension MediaMetaData: Parsable {
    
    mutating func parsing(_ parser: Parser) {
        url <-> parser["url"]
        format <-> parser["format"]
        height <-> parser["height"]
        width <-> parser["width"]
    }
}
