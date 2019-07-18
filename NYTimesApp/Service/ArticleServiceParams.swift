//
//  ArticleServiceParams.swift
//  NYTimesApp
//
//  Created by Apple on 7/18/19.
//  Copyright © 2019 ta. All rights reserved.
//

import Foundation

import Foundation

struct ArticleServiceParams: ServiceBuildable {
    
    var period: Int
    
    var httpMethod: HTTPMethod {
        return .GET
    }
    
    var path: String {
        return "\(period).json?api-key=\(ServiceConfiguration.apiKey)"
    }

}
