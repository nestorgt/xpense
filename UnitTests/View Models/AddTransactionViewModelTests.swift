//
//  AddTransactionViewModelTests.swift
//  UnitTests
//
//  Created by Nestor Garcia on 24/05/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import XCTest
@testable import Xpense

class AddTransactionViewModelTests: XCTestCase {

    var vm: AddTransactionViewModel!
    var categoryServiceMock: CategoryServiceMock!
    var transactionServiceMock: TransactionServiceMock!
    
    override func setUp() {
        super.setUp()
        categoryServiceMock = CategoryServiceMock()
        transactionServiceMock = TransactionServiceMock()
        vm = AddTransactionViewModel(categoryService: categoryServiceMock,
                                     transactionService: transactionServiceMock)
    }
    
    func testIntialState() {
        XCTAssertEqual(vm.screentTitle, NSLocalizedString("add-transaction-title"))
        XCTAssertEqual(vm.titlePlaceholder, NSLocalizedString("add-transaction-title-placeholder"))
        XCTAssertEqual(vm.amountPlaceholder, NSLocalizedString("add-transaction-amount-placeholder"))
        XCTAssertEqual(vm.currencyPlaceholder, NSLocalizedString("add-transaction-currency-placeholder"))
        XCTAssertEqual(vm.categoryPlaceholder, NSLocalizedString("add-transaction-category-placeholder"))
        
        XCTAssertFalse(vm.canSave)
    }
    
    func testSaveButton_AllInputsValid() {
        vm.selectedTitle = "a title"
        XCTAssertFalse(vm.canSave)
        vm.selectedAmount = 19.99
        XCTAssertFalse(vm.canSave)
        vm.selectedDate = Date()
        XCTAssertFalse(vm.canSave)
        vm.selectedCurrency = .USD
        XCTAssertFalse(vm.canSave)
        vm.selectedCategory = CategoryMock.sampleBills
        XCTAssertTrue(vm.canSave)
    }
 
    func testSaveAction() {
        let date = Date()
        let category = CategoryMock.sampleBills
        vm.selectedTitle = "a title"
        vm.selectedAmount = 19.99
        vm.selectedDate = date
        vm.selectedCurrency = .USD
        vm.selectedCategory = category
        
        var calledDidFinishSavingBlock = false
        vm.didFinishSaving = { _ in
            calledDidFinishSavingBlock = true
        }
        
        vm.save()
        
        XCTAssertTrue(calledDidFinishSavingBlock)
        XCTAssertEqual(transactionServiceMock.savedTransaction?.title, "a title")
        XCTAssertEqual(transactionServiceMock.savedTransaction?.amount, 19.99)
        XCTAssertEqual(transactionServiceMock.savedTransaction?.date, date)
        XCTAssertEqual(transactionServiceMock.savedTransaction?.currency, .USD)
        XCTAssertEqual(transactionServiceMock.savedTransaction?.category, category)
    }
}
