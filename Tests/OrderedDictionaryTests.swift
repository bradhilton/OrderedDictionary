//
//  OrderedDictionaryTests.swift
//  OrderedDictionaryTests
//
//  Created by Bradley Hilton on 4/1/16.
//  Copyright © 2016 Brad Hilton. All rights reserved.
//

import XCTest
@testable import OrderedDictionary

class OrderedDictionaryTests: XCTestCase {
    
    func testOrderedDictionary() {
        var dictionary: OrderedDictionary<String, String> = ["_id" : "0", "name" : "Brad"]
        XCTAssert(dictionary.count == 2)
        dictionary += ["public" : "true"]
        XCTAssert(dictionary.count == 3)
        XCTAssert(dictionary["_id"] == "0")
        XCTAssert(dictionary[0] == ("_id", "0"))
        XCTAssert(dictionary[1] == ("name", "Brad"))
        XCTAssert(dictionary[2] == ("public", "true"))
        dictionary["name"] = nil
        XCTAssert(dictionary.count == 2)
        XCTAssert(dictionary[1] == ("public", "true"))
    }
    
    func testAnimalsOrderedDictionary() {
        var dictionary: OrderedDictionary<String, Int> = ["cats": 10]
        XCTAssert(dictionary == ["cats": 10])
        dictionary += ["dogs": 22, "lions": 5]
        XCTAssert(dictionary == ["cats": 10, "dogs": 22, "lions": 5])
        dictionary[1] = ("lions", 7)
        XCTAssert(dictionary == ["cats" : 10, "lions": 7])
        dictionary += ["cats": 18]
        XCTAssert(dictionary == ["lions": 7, "cats": 18])
    }
    
}

func ==<T : Hashable, U : Equatable>(lhs: OrderedDictionary<T, U>, rhs: OrderedDictionary<T, U>) -> Bool {
    guard lhs.count == rhs.count else {
        return false
    }
    for (lhs, rhs) in zip(lhs, rhs) {
        if lhs != rhs {
            return false
        }
    }
    return true
}
