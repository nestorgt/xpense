//
//  TransactionCellModelTests.swift
//  UnitTests
//
//  Created by Nestor Garcia on 24/05/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import XCTest
@testable import Xpense

class TransactionCellModelTests: XCTestCase {

    var vm: TransactionCellModel!
    var transactionServiceMock: TransactionServiceMock!
    var currencyLayerRepositoryMock: CurrencyLayerRepositoryMock!
    
    override func setUp() {
        super.setUp()
        transactionServiceMock = TransactionServiceMock()
        currencyLayerRepositoryMock = CurrencyLayerRepositoryMock()

    }
    
    func testWithConversion() {
        make(convertedAmount: "10", convertedCurrency: "USD")
        var amountResult: String?
        var currencyResult: String?
        
        let expectation = XCTestExpectation(description: "Calls completion")
        vm.fetchConversionIfNeeded { (amount, currency) in
            amountResult = amount
            currencyResult = currency
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
        
        XCTAssertNil(amountResult)
        XCTAssertNil(currencyResult)
    }
    
    func testWithOutConversion_FetchesThroughRepository() {
        make(convertedAmount: nil, convertedCurrency: nil)
        let conversionResponse = CurrencyLayerConvertResponseMock.sample
        currencyLayerRepositoryMock.nextResult = .success(conversionResponse)
        
        var amountResult: String?
        var currencyResult: String?
        let expectation = XCTestExpectation(description: "Calls completion")
        vm.fetchConversionIfNeeded { (amount, currency) in
            amountResult = amount
            currencyResult = currency
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
        
        XCTAssertEqual(amountResult, "\(conversionResponse.result ?? 0)")
        XCTAssertEqual(currencyResult, conversionResponse.query?.to)
    }
    
    private func make(convertedAmount: String?, convertedCurrency: String?) {
        vm = TransactionCellModel(id: "asdasdas",
                                  title: "a tittle",
                                  date: Date(),
                                  amount: "10",
                                  currency: .USD,
                                  convertedAmount: convertedAmount,
                                  convertedCurrency: Currency(rawValue: convertedCurrency ?? ""),
                                  currencyLayerRepository: currencyLayerRepositoryMock,
                                  transactionService: transactionServiceMock)
    }
}
