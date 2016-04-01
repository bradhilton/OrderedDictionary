//
//  OrderedDictionary+CustomStringConvertible.swift
//  OrderedDictionary
//
//  Created by Bradley Hilton on 4/1/16.
//  Copyright © 2016 Brad Hilton. All rights reserved.
//

extension OrderedDictionary : CustomStringConvertible, CustomDebugStringConvertible {
    
    /// A textual representation of `self`.
    public var description: String {
        return "[" + self.map { "\(description($0)): \(description($1))" }.joinWithSeparator(", ") + "]"
    }
    
    private func description<T>(x: T) -> String {
        if let x = x as? String {
            return "\"\(x)\""
        } else {
            return String(x)
        }
    }
    
    /// A textual representation of `self`, suitable for debugging.
    public var debugDescription: String {
        return description
    }
    
}
