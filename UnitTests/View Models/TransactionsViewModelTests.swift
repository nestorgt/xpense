//
//  TransactionsViewModelTests.swift
//  UnitTests
//
//  Created by Nestor Garcia on 24/05/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import XCTest
@testable import Xpense

class TransactionsViewModelTests: XCTestCase {

    var vm: TransactionsViewModel!
    var transactionServiceMock: TransactionServiceMock!
    
    override func setUp() {
        super.setUp()
        transactionServiceMock = TransactionServiceMock()
        vm = TransactionsViewModel(transactionService: transactionServiceMock)
    }
    
    func testIntialState() {
        XCTAssertEqual(TransactionsViewModel.ViewMode.byDay.title, NSLocalizedString("transaction-list-by-day"))
        XCTAssertEqual(TransactionsViewModel.ViewMode.byMonth.title, NSLocalizedString("transaction-list-by-month"))
        XCTAssertEqual(vm.screentTitle, NSLocalizedString("transaction-tab-title"))
        XCTAssertEqual(vm.viewMode, .byDay)
        XCTAssertEqual(vm.transactionCellModels.count, 0)
        XCTAssertEqual(vm.transactionCellModelsByDay.count, 0)
        XCTAssertEqual(vm.transactionCellModelsByMonth.count, 0)
        XCTAssertEqual(vm.numberOfSections, 0)
        XCTAssertEqual(vm.numberOfRowsInSection(0), 0)
    }
    
    func testDebugData_ByDay() {
        transactionServiceMock.nextFetchTransactions =
            [TransactionMock.sample6, TransactionMock.sample4, TransactionMock.sample5,
             TransactionMock.sample2, TransactionMock.sample3, TransactionMock.sample1]
        
        vm.viewMode = .byDay
        vm.refresh()
        
        XCTAssertEqual(vm.transactionCellModels.count, 6)
        XCTAssertEqual(vm.transactionCellModelsByDay.count, 4)
        XCTAssertEqual(vm.numberOfSections, 4)
        XCTAssertEqual(vm.numberOfRowsInSection(0), 1)
        XCTAssertEqual(vm.numberOfRowsInSection(1), 1)
        XCTAssertEqual(vm.numberOfRowsInSection(2), 1)
        XCTAssertEqual(vm.numberOfRowsInSection(3), 3)
    }
    
    func testDebugData_ByMonth() {
        transactionServiceMock.nextFetchTransactions =
            [TransactionMock.sample6, TransactionMock.sample4, TransactionMock.sample5,
             TransactionMock.sample2, TransactionMock.sample3, TransactionMock.sample1]
        
        vm.viewMode = .byMonth
        vm.refresh()
        
        XCTAssertEqual(vm.transactionCellModels.count, 6)
        XCTAssertEqual(vm.transactionCellModelsByMonth.count, 2)
        XCTAssertEqual(vm.numberOfSections, 2)
        XCTAssertEqual(vm.numberOfRowsInSection(0), 3)
        XCTAssertEqual(vm.numberOfRowsInSection(1), 3)
    }
    
    func testDebugData_ByMonth_AddingNewTransactions() {
        transactionServiceMock.nextFetchTransactions =
            [TransactionMock.sample6, TransactionMock.sample4, TransactionMock.sample5,
             TransactionMock.sample2, TransactionMock.sample3, TransactionMock.sample1]
        
        vm.viewMode = .byMonth
        vm.refresh()
        
        // Adding to the beginning
        let newTx = Transaction(id: "aso293hn",
                                title: "a new one",
                                amount: 1000,
                                currency: .USD,
                                category: CategoryMock.sampleBills,
                                date: Date())
        transactionServiceMock.nextFetchTransactions.append(newTx)
        vm.refresh()
        
        XCTAssertEqual(vm.transactionCellModels.count, 7)
        XCTAssertEqual(vm.transactionCellModelsByMonth.count, 3)
        XCTAssertEqual(vm.numberOfSections, 3)
        XCTAssertEqual(vm.numberOfRowsInSection(0), 1)
        XCTAssertEqual(vm.numberOfRowsInSection(1), 3)
        XCTAssertEqual(vm.numberOfRowsInSection(2), 3)
        
        // Adding to the end
        let newTx2 = Transaction(id: "aso293hn",
                                title: "a new one",
                                amount: 1000,
                                currency: .USD,
                                category: CategoryMock.sampleBills,
                                date: Date.date(from: "2010-01-01")!)
                                    
        transactionServiceMock.nextFetchTransactions.append(newTx2)
        vm.refresh()
        
        XCTAssertEqual(vm.transactionCellModels.count, 8)
        XCTAssertEqual(vm.transactionCellModelsByMonth.count, 4)
        XCTAssertEqual(vm.numberOfSections, 4)
        XCTAssertEqual(vm.numberOfRowsInSection(0), 1)
        XCTAssertEqual(vm.numberOfRowsInSection(1), 3)
        XCTAssertEqual(vm.numberOfRowsInSection(2), 3)
        XCTAssertEqual(vm.numberOfRowsInSection(3), 1)
    }
}
