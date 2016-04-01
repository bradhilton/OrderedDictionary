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
        print(dictionary)
        XCTAssert(dictionary.count == 2)
        dictionary += ["public" : "true"]
        print(dictionary)
        XCTAssert(dictionary.count == 3)
        XCTAssert(dictionary["_id"] == "0")
        XCTAssert(dictionary[0] == ("_id", "0"))
        XCTAssert(dictionary[1] == ("name", "Brad"))
        XCTAssert(dictionary[2] == ("public", "true"))
        dictionary["name"] = nil
        print(dictionary)
        XCTAssert(dictionary.count == 2)
        XCTAssert(dictionary[1] == ("public", "true"))
        let string = "Brad"
        print(string)
    }
    
}
