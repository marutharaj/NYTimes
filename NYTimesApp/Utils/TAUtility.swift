//
//  TAUtility.swift
//  NYTimesApp
//
//  Created by Marutharaj Kuppusamy on 10/20/18.
//  Copyright © 2019 ta. All rights reserved.
//

import Foundation

class TAUtility {
    func dateFromString(date: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd"
        return dateFormatter.date(from: date)!
    }
    
    func stringFromDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd"
        return dateFormatter.string(from: date)
    }
    
    func getArticleThumbnailUrl(article: Article) -> URL {
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
