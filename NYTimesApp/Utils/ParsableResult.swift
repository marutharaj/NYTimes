//
//  ParsableResult.swift
//  NYTimesApp
//
//  Created by Apple on 7/18/19.
//  Copyright © 2019 ta. All rights reserved.
//

import UIKit

// MARK: - Definitions -

public func <-> <T>(left: inout T, right: (parser: Parser, willSet: (T) -> T)) {
    switch right.parser.mode {
    case .fromJSON:
        var value = left
        value <-> right.parser
        left = right.willSet(value)
    default:
        left <-> right.parser
    }
}

// MARK: - Type - ParsableResult

public protocol ParsableResult: Parsable {
    
    init(jsonObject: JSON) throws
    static func parseResult(json: JSON) -> NYTimesResult<Self>
}

// MARK: - Extension - ParsableResult

extension ParsableResult {
    
    init(jsonObject: JSON) throws {
        self.init(json: jsonObject)
    }
    
    static func parseResult(json: JSON) -> NYTimesResult<Self> {
        do {
            let model = try Self.init(jsonObject: json)
            return .success(model)
        } catch {
            return .failure(error)
        }
    }
}
