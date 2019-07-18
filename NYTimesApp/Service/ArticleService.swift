//
//  ArticleService.swift
//  NYTimesApp
//
//  Created by Marutharaj Kuppusamy on 17/07/19.
//  Copyright © 2019 ta. All rights reserved.
//

import Foundation

typealias CompletionBlock = ((Bool, NYTimesResponse?, _ error: String) -> ())?

class ArticleService: NetworkAdapter {
    
    var article = [Article]()
    
    func sendRequest(period: Int, completion: CompletionBlock) {
        let params = ArticleServiceParams(period: period)
        fetch(JSONResource<NYTimesResponse>(with: params)) { (result) in
            switch result {
            case .success(_):
                print("Success getting article: \(result)")
                completion?(true, result.value, "")
            case let .failure(error):
                print("Error getting article: \(error)")
                completion?(false, nil, error.localizedDescription)
            }
        }
    }
}
