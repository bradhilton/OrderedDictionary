//
//  OrderedDictionary+Array.swift
//  OrderedDictionary
//
//  Created by Bradley Hilton on 4/1/16.
//  Copyright © 2016 Brad Hilton. All rights reserved.
//

extension OrderedDictionary : RangeReplaceableCollectionType {
    
    /// Replace the given `subRange` of elements with `newElements`.
    public mutating func replaceRange<C : CollectionType where C.Generator.Element == IndexingGenerator<OrderedDictionary>.Element>(subRange: Range<Index>, with newElements: C) {
        keysArray[subRange].forEach { self.dictionary[$0] = nil }
        keysArray.replaceRange(subRange, with: newElements.map { $0.0 })
        newElements.forEach { self.dictionary[$0] = $1 }
    }
    
    public var capacity: Int {
        return keysArray.capacity
    }
    
    /// If `!self.isEmpty`, remove the last element and return it, otherwise
    /// return `nil`.
    public mutating func popLast() -> (Key, Value)? {
        guard let key = keysArray.popLast() else { return nil }
        return (key, dictionary.removeValueForKey(key)!)
    }
    
}

/// Operator form of `appendContentsOf`.
public func +=<Key : Hashable, Value, S : SequenceType where S.Generator.Element == (Key, Value)>(inout lhs: OrderedDictionary<Key, Value>, rhs: S) {
    lhs.appendContentsOf(rhs)
}
