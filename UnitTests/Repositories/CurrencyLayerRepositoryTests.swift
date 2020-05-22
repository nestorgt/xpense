//
//  CurrencyLayerRepositoryTests.swift
//  UnitTests
//
//  Created by Nestor Garcia on 22/05/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import XCTest
@testable import Xpense

class CurrencyLayerRepositoryTests: XCTestCase {

    var apiServiceMock: APIServiceMock!
    var currencyLayerRepository: CurrencyLayerRepositoryProtocol!
    var result: Result<CurrencyLayerConvertResponse, RepositoryError>!
    
    override func setUp() {
        super.setUp()
        apiServiceMock = APIServiceMock()
        currencyLayerRepository = CurrencyLayerRepository(apiService: apiServiceMock)
    }
    
    func testGetConversion_Success() {
        let expectation = XCTestExpectation(description: "Performs a request")
        let data = CurrencyLayerConvertResponseMock.sampleData()
        apiServiceMock.nextResult = .success(data)
        
        currencyLayerRepository
            .getConversion(fromCurrency: .USD, toCurrency: .NZD, amount: 10, on: Date()) { [weak self] result in
                self?.result = result
                expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
        
        XCTAssertTrue(result.isSuccess)
        let expectedResponse = try! JSONDecoder.xpense.decode(CurrencyLayerConvertResponse.self, from: data)
        XCTAssertTrue(result.value == expectedResponse)
    }
    
    func testGetConversion_Failure_BadRequest() {
        let expectation = XCTestExpectation(description: "Performs a request")
        apiServiceMock.nextResult = .failure(.badRequest)
        
        currencyLayerRepository
            .getConversion(fromCurrency: .USD, toCurrency: .NZD, amount: 10, on: Date()) { [weak self] result in
                self?.result = result
                expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
        
        XCTAssertTrue(result.isFailure)
        XCTAssertTrue(result.error as? RepositoryError == RepositoryError.apiError(.badRequest))
    }
    
    func testGetConversion_Failure_NotFound() {
        let expectation = XCTestExpectation(description: "Performs a request")
        apiServiceMock.nextResult = .failure(.notFound)
        
        currencyLayerRepository
            .getConversion(fromCurrency: .USD, toCurrency: .NZD, amount: 10, on: Date()) { [weak self] result in
                self?.result = result
                expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
        
        XCTAssertTrue(result.isFailure)
        XCTAssertTrue(result.error as? RepositoryError == RepositoryError.apiError(.notFound))
    }
}
