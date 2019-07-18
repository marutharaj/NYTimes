//
//  NYUtility.swift
//  NYTimesApp
//
//  Created by Marutharaj Kuppusamy on 18/07/19.
//  Copyright © 2019 ta. All rights reserved.
//

import Foundation

struct NYUtility {
    
    static func getArticleThumbnailUrl(article: Article) -> URL {
        var imageUrlString: String = ""
        for mediaMetaData in (article.media[0].mediaMetaData) {
            if mediaMetaData.format == "Standard Thumbnail" || mediaMetaData.format == "mediumThreeByTwo210"{
                imageUrlString = mediaMetaData.url!
                break
            }
        }
        
        return URL(string: imageUrlString)!
    }
}
