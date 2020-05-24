//
//  TransactionServiceTests.swift
//  UnitTests
//
//  Created by Nestor Garcia on 24/05/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import XCTest
@testable import Xpense

class TransactionServiceTests: XCTestCase {

    var transactionService: TransactionService!
    var databaseServiceMock: DatabaseServiceMock!
    
    override func setUp() {
        super.setUp()
        databaseServiceMock = DatabaseServiceMock()
        transactionService = TransactionService(databaseService: databaseServiceMock)
    }

    func testFetchTransactions_CreatesDefaultOnes() {
        databaseServiceMock.nextFetchTransactions = []
        
        _ = transactionService.fetchTransactions()
        
        XCTAssertEqual(databaseServiceMock.savedTransactions.count, 6)
    }
    
    func testFetchTransactions_UsesDatabase() {
        databaseServiceMock.nextFetchTransactions = [TransactionMock.sample1]
        
        let result = transactionService.fetchTransactions()
        
        XCTAssertEqual(databaseServiceMock.savedTransactions.count, 0)
        XCTAssertEqual(result.count, 1)
    }
    
    func testSaveTransaction() {
        let transaction = TransactionMock.sample2
        
        transactionService.save(transaction: transaction)
        
        XCTAssertEqual(databaseServiceMock.savedTransactions, [transaction])
    }
    
    func testUpdateConversion() {
        let transaction = TransactionMock.sample1
        databaseServiceMock.nextFetchTransactions = [TransactionMock.sample1]
        
        let result = transactionService.fetchTransactions()
        
        XCTAssertEqual(result, [transaction])
        XCTAssertNil(transaction.convertedAmount)
        XCTAssertNil(transaction.convertedCurrency)
        
        transactionService.updateConversion(amount: "123", currency: "NZD", on: transaction.id)
        
        XCTAssertEqual(databaseServiceMock.savedTransactions.last?.convertedAmount, "123")
        XCTAssertEqual(databaseServiceMock.savedTransactions.last?.convertedCurrency, Currency(rawValue: "NZD"))
    }
}
