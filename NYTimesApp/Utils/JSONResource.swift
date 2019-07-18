//
//  JSONResource.swift
//  NYTimesApp
//
//  Created by Apple on 7/18/19.
//  Copyright © 2019 ta. All rights reserved.
//

import Foundation

public struct JSONResource<T: ParsableResult> {
    
    public let parse = T.parseResult
    public let buildable: ServiceBuildable
    
    public init(with params: ServiceBuildable) {
        self.buildable = params
    }
}
