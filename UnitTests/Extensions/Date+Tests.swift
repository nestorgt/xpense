//
//  Date+Tests.swift
//  UnitTests
//
//  Created by Nestor Garcia on 22/05/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import XCTest
@testable import Xpense

class DateTests: XCTestCase {

    func testDate_OK() {
        XCTAssertNotNil(Date.date(from: "2020-01-01", withFormat: "yyyy-MM-dd"))
        XCTAssertNotNil(Date.date(from: "01-01-2020", withFormat: "dd-MM-yyyy"))
    }
    
    func testDate_Nil() {
        XCTAssertNil(Date.date(from: "", withFormat: "yyyy-MM-dd"))
        XCTAssertNil(Date.date(from: "not a date", withFormat: "yyyy-MM-dd"))
        XCTAssertNil(Date.date(from: "01-01-2020", withFormat: "yyyy-MM-dd"))
    }
}
