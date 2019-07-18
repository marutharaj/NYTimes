//
//  NetworkConstants.swift
//  NYTimesApp
//
//  Created by Apple on 7/18/19.
//  Copyright © 2019 ta. All rights reserved.
//

import Foundation

public enum HTTPMethod: String {
    case GET
}

public enum HTTPTimeout: Int {
    case ninety     = 90 // default
}

public struct NetworkConstants {

    public enum ContentTypes: String {
        case json = "application/json"
    }
    
    public enum HTTPErrorCodes: Int {
        case noContent              = 204
        case badRequest             = 400
        case unauthorized           = 401
        case notFound               = 404
        case decryptionFailure      = 406
        case internalServerError    = 500
        case serviceUnavailable     = 503
        
        init?(with response: URLResponse?) {
            guard
                let httpResponse = response as? HTTPURLResponse,
                let code = HTTPErrorCodes(rawValue: httpResponse.statusCode)
                else {
                    return nil
            }
            
            self = code
        }
    }
}

public enum JSONError: Error {
    case incorrect
    
    public var string: String {
        return "UnexpectedError"
    }
}

public enum JSONContentError: Error {
    case failure
    case general(cause: String)
    
    public init(_ cause: String) {
        self = JSONContentError.general(cause: cause)
    }
    
    public var string: String {
        var errorMsg = ""
        
        switch self {
        case .failure:
            errorMsg = "Failure"
        case .general(let cause):
            errorMsg = cause
        }
        
        return errorMsg
    }
}

public enum NYError: Error {
    
    case emptyData
    case serviceFailure(NetworkConstants.HTTPErrorCodes?)
    case general(cause: String)

    init(_ cause: String) {
        self = NYError.general(cause: cause)
    }
    
    public var string: String {
        switch self {
        case .emptyData:
            return "Unexpected Error"
        case .serviceFailure(_):
            return "Service Failure"
        case .general(let cause):
            return cause
        }
    }
}

