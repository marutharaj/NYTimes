//
//  NYTimesResult.swift
//  NYTimesApp
//
//  Created by Apple on 7/18/19.
//  Copyright © 2019 ta. All rights reserved.
//

import Foundation

public enum NYTimesResult<T> {
    case success(T)
    case failure(Error)
    
    // f is a function that when proccessed returns a specific value
    public func map<U>(_ f: (T) -> U) -> NYTimesResult<U> {
        switch self {
        case .success(let value):
            return .success(f(value))
        case .failure(let error):
            return .failure(error)
        }
    }
    
    // f is a function that when proccessed returns another Result<> enum
    public func flatMap<U>(_ f: (T) -> NYTimesResult<U>) -> NYTimesResult<U> {
        switch self {
        case .success(let value):
            return f(value)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    public var isSuccess: Bool {
        switch self {
        case .success:
            return true
        case .failure:
            return false
        }
    }
    
    public var value: T? {
        switch self {
        case .success(let value):
            return value
        case .failure:
            return nil
        }
    }
}
