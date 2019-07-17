//
//  ArticleService.swift
//  NYTimesApp
//
//  Created by Marutharaj Kuppusamy on 17/07/19.
//  Copyright © 2019 ta. All rights reserved.
//

import Foundation

class ArticleService {
    var article = [Article]()
    
    init() {
        
    }
    
    func sendRequest(period: Int, completionHandler:@escaping (_ articles: [Article]) -> Void) {
        let periodJSON: String = String(period) + ".json"
        let queryString: String = "?api-key=" + ServiceConstants.apiKey
        let url = URL(string: ServiceConstants.articleUrl + periodJSON + queryString)
        
        let task = URLSession.shared.dataTask(with: url!) {(data, _, error ) in
            guard error == nil else {
                print("returning error")
                return
            }
            
            guard let data = data else {
                print("not returning data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let articlesData = try decoder.decode(Articles.self, from: data)
                completionHandler(articlesData.articles)
            } catch let err {
                print("Error in parsing", err)
            }
        }
        
        task.resume()
    }
}
