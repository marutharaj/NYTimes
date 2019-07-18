//
//  ServerBaseResponse.swift
//  NYTimesApp
//
//  Created by Apple on 7/18/19.
//  Copyright © 2019 ta. All rights reserved.
//

import Foundation

struct ServerBaseResponse: ParsableResult {
    
    private(set) var errorCode: String?
    private(set) var status: String?
    private(set) var content: JSON?
    
    init() {
        // No Code
    }
    
    init(jsonObject: JSON) throws {
        self.init(json: jsonObject)
        
        if let errorCode = errorCode {
            switch errorCode {
            case JSONContentError.failure.string, "":
                throw NYError.serviceFailure(nil)
            default:
                throw JSONContentError(errorCode)
            }
        }
    }
    
    mutating func parsing(_ parser: Parser) {
        errorCode <-> parser["fault.faultstring.detail.errorcode"]
        status <-> parser["status"]
        content <-> parser["response"]
    }
}
