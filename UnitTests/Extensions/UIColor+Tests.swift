//
//  UIColor+Tests.swift
//  UnitTests
//
//  Created by Nestor Garcia on 22/05/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import XCTest
@testable import Xpense

class UIColorTests: XCTestCase {

    func testColor_OK() {
        XCTAssertNotNil(UIColor(hex: "#0000FF"))
        XCTAssertNotNil(UIColor(hex: "#0000ff"))
        XCTAssertNotNil(UIColor(hex: "#aaaaaa"))
        XCTAssertNotNil(UIColor(hex: "#AAAAAA"))
    }
    
    func testColor_Nil() {
        XCTAssertNil(UIColor(hex: "#12345"))
        XCTAssertNil(UIColor(hex: "#1234567"))
        XCTAssertNil(UIColor(hex: "123456"))
        XCTAssertNil(UIColor(hex: "#ZZZZZZ"))
    }
    
    func testRoundTrip() {
        let originalHex = "#0000FF"
        let transformedHex = UIColor(hex: originalHex)?.toHex
        
        XCTAssertEqual(originalHex, transformedHex)
    }
}
