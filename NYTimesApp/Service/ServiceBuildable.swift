//
//  ServiceBuildable.swift
//  NYTimesApp
//
//  Created by Apple on 7/18/19.
//  Copyright © 2019 ta. All rights reserved.
//

import Foundation

public protocol ServiceBuildable {
    
    var httpMethod: HTTPMethod { get }
    var path: String { get }
    var httpTimeout: HTTPTimeout { get }
}

public extension ServiceBuildable {
    
    var httpTimeout: HTTPTimeout {
        return .ninety
    }
}

extension ServiceBuildable {

    func build() -> URLRequest {
        
        let urlString = ServiceConfiguration.articleUrl + path
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        
        request.timeoutInterval = TimeInterval(httpTimeout.rawValue)
        
        return request
    }
}
