//
//  OrderedDictionary.swift
//  OrderedDictionary
//
//  Created by Bradley Hilton on 4/1/16.
//  Copyright © 2016 Brad Hilton. All rights reserved.
//

//Dictionary

public struct OrderedDictionary<Key : Hashable, Value> : CollectionType, DictionaryLiteralConvertible {
    
    internal var keysArray: [Key] = []
    internal var dictionary: [Key: Value] = [:]
    
    /// Create an empty ordered dictionary.
    public init() {}
    
    /// Create a dictionary with at least the given number of
    /// elements worth of storage.  The actual capacity will be the
    /// smallest power of 2 that's >= `minimumCapacity`.
    public init(minimumCapacity: Int) {
        self.dictionary = Dictionary(minimumCapacity: minimumCapacity)
        self.keysArray.reserveCapacity(minimumCapacity)
    }

    public var startIndex: Int { return keysArray.startIndex }
    public var endIndex: Int { return keysArray.endIndex }

    @warn_unused_result
    public func indexForKey(key: Key) -> Int? {
        return keysArray.indexOf(key)
    }

    public subscript (position: Int) -> (Key, Value) {
        get {
            let key = keysArray[position]
            return (key, dictionary[key]!)
        }
        set(pair) {
            let key = pair.0
            let value = pair.1
            
            // Clear existing key/value pair from dictionary
            dictionary[keysArray[position]] = nil
            
            // Remove key from current position in keysArray if present
            if let index = indexForKey(key) {
                keysArray.removeAtIndex(index)
            }
            
            // Set key in keysArray at new position
            keysArray[position] = key
            
            // Set key/value pair in backing dictionary
            dictionary[key] = value
        }
    }
    
    /// Access the value associated with the given key.
    ///
    /// Reading a key that is not present in `self` yields `nil`.
    /// Writing `nil` as the value for a given key erases that key from
    /// `self`.
    public subscript (key: Key) -> Value? {
        get {
            return dictionary[key]
        }
        set(value) {
            switch (value, indexForKey(key)) {
            case (let value?, _?): // Set value for existing key/value pair
                dictionary[key] = value
            case (let value?, nil): // Append new key/value pair
                keysArray.append(key)
                dictionary[key] = value
            case (nil, let index?): // Remove existing key/value pair
                keysArray.removeAtIndex(index)
                dictionary[key] = nil
            case (nil, nil): break // Remove nonexistant key/value pair; i.e. do nothing
            }
        }
    }
    
    /// Update the value stored in the dictionary for the given key, or, if the
    /// key does not exist, add a new key-value pair to the dictionary.
    ///
    /// Returns the value that was replaced, or `nil` if a new key-value pair
    /// was added.
    public mutating func updateValue(value: Value, forKey key: Key) -> Value? {
        let original = self[key]
        self[key] = value
        return original
    }
    
    /// Remove the key-value pair at `Index`.
    ///
    /// Invalidates all indices with respect to `self`.
    ///
    /// - Complexity: O(`self.count`).
    public mutating func removeAtIndex(index: Int) -> (Key, Value) {
        let key = keysArray.removeAtIndex(index)
        let value = dictionary.removeValueForKey(key)!
        return (key, value)
    }
    
    /// Remove a given key and the associated value from the dictionary.
    /// Returns the value that was removed, or `nil` if the key was not present
    /// in the dictionary.
    public mutating func removeValueForKey(key: Key) -> Value? {
        guard let index = indexForKey(key) else { return nil }
        return dictionary.removeValueForKey(keysArray.removeAtIndex(index))
    }
    
    /// Removes all elements.
    ///
    /// - Postcondition: `capacity == 0` if `keepCapacity` is `false`, otherwise
    ///   the capacity will not be decreased.
    ///
    /// Invalidates all indices with respect to `self`.
    ///
    /// - parameter keepCapacity: If `true`, the operation preserves the
    ///   storage capacity that the collection has, otherwise the underlying
    ///   storage is released.  The default is `false`.
    ///
    /// Complexity: O(`self.count`).
    public mutating func removeAll(keepCapacity keepCapacity: Bool = false) {
        keysArray.removeAll(keepCapacity: keepCapacity)
        dictionary.removeAll(keepCapacity: keepCapacity)
    }

    /// A collection containing just the keys of `self`.
    ///
    /// Keys appear in the same order as they occur as the `.0` member
    /// of key-value pairs in `self`.  Each key in the result has a
    /// unique value.
    public var keys: LazyMapCollection<OrderedDictionary, Key> {
        return lazy.map { $0.0 }
    }
    
    /// A collection containing just the values of `self`.
    ///
    /// Values appear in the same order as they occur as the `.1` member
    /// of key-value pairs in `self`.
    public var values: LazyMapCollection<OrderedDictionary, Value> {
        return lazy.map { $0.1 }
    }
    
    /// Create an instance initialized with `elements`.
    public init(dictionaryLiteral elements: (Key, Value)...) {
        for (key, value) in elements {
            keysArray.append(key)
            dictionary[key] = value
        }
    }
    
    /// If `!self.isEmpty`, return the first key-value pair in the sequence of
    /// elements, otherwise return `nil`.
    public mutating func popFirst() -> (Key, Value)? {
        guard let key = keysArray.first else { return nil }
        return (keysArray.removeAtIndex(0), dictionary.removeValueForKey(key)!)
    }
    
}