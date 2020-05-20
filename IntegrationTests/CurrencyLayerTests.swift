//
//  CurrencyLayerTests.swift
//  IntegrationTests
//
//  Created by Nestor Garcia on 20/05/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import XCTest
@testable import Xpense

final class CurrencyLayerTests: XCTestCase {

    var apiService: APIService!
    var result: Result<Data, APIError>!
    
    override func setUp() {
        super.setUp()
        apiService = APIService()
    }
    
    // MARK: - Tests

    func testConvertSuccess_USDNZD_10() throws {
        performAndWait(for: CurrencyLayerRouter.convert(fromCurrency: .USD, toCurrency: .NZD, amount: 10)!,
                       with: XCTestExpectation(description: "Performs a request"))
        
        XCTAssertTrue(result.isSuccess)
    }
    
    func testConvertSuccess_EURUSD_100() throws {
        performAndWait(for: CurrencyLayerRouter.convert(fromCurrency: .EUR, toCurrency: .USD, amount: 100)!,
                       with: XCTestExpectation(description: "Performs a request"))
        
        XCTAssertTrue(result.isSuccess)
    }
    
    func testConvertSuccess_EURUSD_100_CustomDate() throws {
        let date = Date.date(from: "2010-01-01", withFormat: "yyyy-MM-dd")!
        performAndWait(for: CurrencyLayerRouter.convert(fromCurrency: .EUR, toCurrency: .USD, amount: 100, on: date)!,
                       with: XCTestExpectation(description: "Performs a request"))
        
        XCTAssertTrue(result.isSuccess)
    }
    
    // MARK: - Helpers
    
    private func performAndWait(for urlRequest: URLRequest, with expectation: XCTestExpectation) {
        apiService.perform(urlRequest: urlRequest) { [weak self] result in
            self?.result = result
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }
}
