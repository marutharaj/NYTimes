//
//  NetworkAdapter.swift
//  NYTimesApp
//
//  Created by Apple on 7/18/19.
//  Copyright © 2019 ta. All rights reserved.
//

import Foundation

typealias ResultCompletionData = (NYTimesResult<Data>) -> Void

class NetworkAdapter: NSObject {
    
    var currentTask: URLSessionDataTask?
    
    fileprivate func makeJSONResult(with data: Data?) -> NYTimesResult<JSON> {
        
        guard let json = JSON(with: data) else {
            return .failure(JSONError.incorrect)
        }
        
        do {
            let response = try ServerBaseResponse(jsonObject: json)
            return .success(response.content ?? json)
        } catch {
            return .failure(error)
        }
    }
    
    fileprivate func makeJSON(with result: NYTimesResult<Data>) -> NYTimesResult<JSON> {
        
        return makeJSONResult(with: result.value)
    }
    
    func fetch<T>(_ resource: JSONResource<T>, completion: @escaping (NYTimesResult<T>) -> ()) {
        
        fetchServerResponse(resource.buildable) { (result) in
            
            let jsonResult = self.makeJSON(with: result)
            let resourceResult = jsonResult.flatMap(resource.parse)
            
            switch result {
            case .success(_):
                print("Success getting article: \(result)")
                completion(resourceResult)
            case let .failure(error):
                print("Error getting article: \(error)")
                completion(resourceResult)
            }
        }
    }
    
    func fetchServerResponse(_ buildable: ServiceBuildable, completion: @escaping ResultCompletionData) {
        
        let request = buildable.build()
        
        currentTask = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard error == nil else {
                completion(.failure(NYError.serviceFailure(nil)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NYError.emptyData))
                return
            }
            
            completion(.success(data))
        }
        
        currentTask!.resume()
    }
}
