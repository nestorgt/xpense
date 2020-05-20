//
//  CurrencyLayerRouterTests.swift
//  UnitTests
//
//  Created by Nestor Garcia on 20/05/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import XCTest
@testable import Xpense

class CurrencyLayerRouterTests: XCTestCase {
    
    // MARK: - Tests
    
    func testConverRouter_USDNZD() throws {
        let urlRequest = CurrencyLayerRouter.convert(fromCurrency: .USD, toCurrency: .NZD, amount: 10)
        let stringURL = urlRequest?.url?.absoluteString
        
        XCTAssertNotNil(urlRequest)
        XCTAssertTrue(urlRequest?.url?.host == "api.currencylayer.com")
        XCTAssertTrue(urlRequest?.url?.lastPathComponent == "convert")
        XCTAssertTrue(urlRequest?.httpMethod == "GET")
        XCTAssertNotNil(stringURL)
        XCTAssertTrue(stringURL!.contains("from=USD"))
        XCTAssertTrue(stringURL!.contains("to=NZD"))
        XCTAssertTrue(stringURL!.contains("amount=10"))
    }
    
    func testConverRouter_USDNZD_CustomDate() throws {
        let date = Date.date(from: "2010-01-01", withFormat: "yyyy-MM-dd")!
        let urlRequest = CurrencyLayerRouter.convert(fromCurrency: .EUR, toCurrency: .USD, amount: 100, on: date)
        let stringURL = urlRequest?.url?.absoluteString
        
        XCTAssertNotNil(urlRequest)
        XCTAssertTrue(urlRequest?.url?.host == "api.currencylayer.com")
        XCTAssertTrue(urlRequest?.url?.lastPathComponent == "convert")
        XCTAssertTrue(urlRequest?.httpMethod == "GET")
        XCTAssertNotNil(stringURL)
        XCTAssertTrue(stringURL!.contains("from=EUR"))
        XCTAssertTrue(stringURL!.contains("to=USD"))
        XCTAssertTrue(stringURL!.contains("amount=100"))
        XCTAssertTrue(stringURL!.contains("date=2010-01-01"))
    }
}
