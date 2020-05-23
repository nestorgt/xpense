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

    var currencyLayerRepository: CurrencyLayerRepositoryProtocol!
    var convertResult: Result<CurrencyLayerConvertResponse, RepositoryError>!
    
    override func setUp() {
        super.setUp()
        currencyLayerRepository = CurrencyLayerRepository(apiService: APIService())
    }
    
    // MARK: - Tests

    func testConvertSuccess_USDNZD_10() {
        let expectation = XCTestExpectation(description: "Performs a request")
        currencyLayerRepository
            .getConversion(fromCurrency: .USD, toCurrency: .NZD, amount: 10, on: Date()) { [weak self] result in
                self?.convertResult = result
                expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)

        XCTAssertTrue(convertResult.isSuccess)
        XCTAssertNotNil(convertResult.value)
        XCTAssertEqual(convertResult.value?.success, true)
        XCTAssertEqual(convertResult.value?.query, CurrencyLayerConvertResponse.Query(from: "USD", to: "NZD", amount: 10))
    }
    
    func testConvertSuccess_EURUSD_100() {
        let expectation = XCTestExpectation(description: "Performs a request")
        currencyLayerRepository
            .getConversion(fromCurrency: .EUR, toCurrency: .USD, amount: 100, on: Date()) { [weak self] result in
                self?.convertResult = result
                expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)

        XCTAssertTrue(convertResult.isSuccess)
        XCTAssertNotNil(convertResult.value)
        XCTAssertEqual(convertResult.value?.success, true)
        XCTAssertEqual(convertResult.value?.query, CurrencyLayerConvertResponse.Query(from: "EUR", to: "USD", amount: 100))
    }
    
    func testConvertSuccess_EURUSD_100_CustomDate() {
        let expectation = XCTestExpectation(description: "Performs a request")
        let date = Date.date(from: "2010-01-01")!
        currencyLayerRepository
            .getConversion(fromCurrency: .EUR, toCurrency: .USD, amount: 100, on: date) { [weak self] result in
                self?.convertResult = result
                expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
        
        XCTAssertTrue(convertResult.isSuccess)
        XCTAssertNotNil(convertResult.value)
        XCTAssertEqual(convertResult.value?.success, true)
        XCTAssertEqual(convertResult.value?.query, CurrencyLayerConvertResponse.Query(from: "EUR", to: "USD", amount: 100))
        XCTAssertEqual(convertResult.value?.date, Date.date(from: "2010-01-01"))
    }
    
    func testConvertNoSuccess_FutureDate() {
        let expectation = XCTestExpectation(description: "Performs a request")
        let date = Date.date(from: "2222-01-01")!
        currencyLayerRepository
            .getConversion(fromCurrency: .EUR, toCurrency: .USD, amount: 100, on: date) { [weak self] result in
                self?.convertResult = result
                expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
        
        XCTAssertTrue(convertResult.isSuccess)
        XCTAssertNotNil(convertResult.value)
        XCTAssertEqual(convertResult.value?.success, false)
        XCTAssertEqual(convertResult.value?.error?.code, 106)
        XCTAssertEqual(convertResult.value?.error?.info.isEmpty, false)
    }
}
