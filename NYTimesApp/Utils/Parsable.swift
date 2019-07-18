//
//  Parsable.swift
//  NYTimesApp
//
//  Created by Apple on 7/18/19.
//  Copyright © 2019 ta. All rights reserved.
//

import Foundation

public typealias JSON = [String: Any]

infix operator <->

public protocol Parsable {
    init()
    mutating func parsing(_ parser: Parser)
}

public extension Parsable {
    
    init(json: JSON) {
        self.init()
        self.parsing(Parser(mode: .fromJSON, json: json))
    }
    
    func json() -> JSON {
        let parser = Parser(mode: .toJSON)
        var mutableCopy = self
        
        mutableCopy.parsing(parser)
        
        return parser.json
    }
}

public final class Parser: NSObject {
    
    public enum Mode: Int {
        case fromJSON
        case toJSON
    }
    
    public let mode: Parser.Mode
    fileprivate var json: JSON
    fileprivate var keys: [String] = []
    fileprivate var keyPath: String? {
        didSet {
            self.keys = self.keyPath?.components(separatedBy: ".") ?? []
        }
    }
    
    public subscript(key: String) -> Parser {
        self.keyPath = self.keyPath?.appending(".\(key)") ?? key
        
        return self
    }
    
    public init(mode: Parser.Mode, json: JSON = [:], keyPath: String? = nil) {
        self.mode = mode
        self.json = json
        self.keyPath = keyPath
    }
    
    convenience public init(_ json: JSON) {
        self.init(mode: .fromJSON, json: json, keyPath: nil)
    }
}

extension Dictionary where Key == String, Value == Any {
    
    init?(with bytes: Data?) {
        guard let data = bytes,
            let json = try? JSONSerialization.jsonObject(with: data),
            let jsonObject = json as? JSON else {
                return nil
        }
        
        self = jsonObject
    }
}

extension Parser {
    
    fileprivate var currentNode: Any? {
        var node: Any?
        
        if let key = self.keys.first {
            node = self.json[key]
            
            // Dealing with the nested logic
            self.keys.suffix(from: 1).forEach {
                if let dict = node as? JSON {
                    node = dict[$0]
                }
            }
        } else {
            node = self.json
        }
        
        return node
    }
    
    fileprivate func node(for path: [String]) -> JSON? {
        var node: JSON?
        
        if let key = path.first {
            node = self.json[key] as? JSON
            
            path.suffix(from: 1).forEach {
                node = node?[$0] as? JSON
            }
        } else {
            node = self.json
        }
        
        return node
    }
    
    fileprivate func assignNode(_ json: Any) {
        var keysCopy = self.keys
        var node = json
        var jsonTree = JSON()
        
        self.keys.reversed().forEach {
            keysCopy.removeLast()
            jsonTree = self.node(for: keysCopy) ?? [:]
            jsonTree[$0] = node
            node = jsonTree
        }
        
        if let key = self.keys.first, let dict = node as? JSON {
            self.json[key] = dict[key]
        }
    }
    
    fileprivate static func jsonNode<T>(from value: T) -> Any {
        
        switch value {
        case let parsable as Parsable:
            return parsable.json()
        default:
            return value
        }
    }
    
    fileprivate static func object<T>(_ type: T.Type, from node: Any?) -> T? {
        
        if let newNode = node as? JSON {
            switch type {
            case let parsable as Parsable.Type:
                return parsable.init(json: newNode) as? T
            default:
                return newNode as? T
            }
        } else {
            return node as? T
        }
    }
}

extension Parser {
        
    public static func <-> <T>(left: inout T?, right: Parser) {
        switch right.mode {
        case .fromJSON:
            if let value = Parser.object(T.self, from: right.currentNode) {
                left = value
            }
        default:
            if let value = left {
                right.assignNode(Parser.jsonNode(from: value))
            }
        }
        
        right.keyPath = nil
    }
    
    public static func <-> <T>(left: inout [T]?, right: Parser) {
        switch right.mode {
        case .fromJSON:
            if let value = (right.currentNode as? [Any])?.compactMap({ Parser.object(T.self, from: $0) }) {
                left = value
            }
        default:
            if let value = left {
                right.assignNode(value.map { Parser.jsonNode(from: $0) })
            }
        }
        
        right.keyPath = nil
    }
    
    public static func <-> <T: RawRepresentable>(left: inout T?, right: Parser) {
        switch right.mode {
        case .fromJSON:
            if let value = right.currentNode as? T.RawValue, let raw = T(rawValue: value) {
                left = raw
            }
        default:
            if let value = left {
                right.assignNode(Parser.jsonNode(from: value.rawValue as AnyObject))
            }
        }
        
        right.keyPath = nil
    }
    
    public static func <-> <T>(left: inout T, right: Parser) {
        switch right.mode {
        case .fromJSON:
            if let value = Parser.object(T.self, from: right.currentNode) {
                left = value
            }
        default:
            right.assignNode(Parser.jsonNode(from: left))
        }
        
        right.keyPath = nil
    }
    
    public static func <-> <T>(left: inout [T], right: Parser) {
        switch right.mode {
        case .fromJSON:
            if let value = (right.currentNode as? [Any])?.compactMap({ Parser.object(T.self, from: $0) }) {
                left = value
            }
        default:
            right.assignNode(left.map { Parser.jsonNode(from: $0) })
        }
        
        right.keyPath = nil
    }
    
    public static func <-> <T: RawRepresentable>(left: inout T, right: Parser) {
        switch right.mode {
        case .fromJSON:
            if let value = right.currentNode as? T.RawValue, let raw = T(rawValue: value) {
                left = raw
            }
        default:
            right.assignNode(Parser.jsonNode(from: left.rawValue as AnyObject))
        }
        
        right.keyPath = nil
    }
}
