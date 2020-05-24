//
//  AddTransactionViewModel.swift
//  Xpense
//
//  Created by Nestor Garcia on 24/05/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import UIKit

final class AddTransactionViewModel {

    private let categoryService: CategoryServiceProtocol
    private let transactionService: TransactionServiceProtocol
    private var categories: [Category] = []
    
    init(categoryService: CategoryServiceProtocol = DI.categoryService,
         transactionService: TransactionServiceProtocol = DI.transactionService) {
        self.categoryService = categoryService
        self.transactionService = transactionService
    }
    
    var screentTitle: String { NSLocalizedString("add-transaction-title") }
    
    var selectedTitle: String? {
        didSet { shouldRefresh?() }
    }
    var titlePlaceholder: String { NSLocalizedString("add-transaction-title-placeholder") }
    
    var selectedAmount: Double? {
        didSet { shouldRefresh?() }
    }
    var amountPlaceholder: String { NSLocalizedString("add-transaction-amount-placeholder") }
    
    var selectedCurrency: Currency?
    var currencyPlaceholder: String {
        if let currencyName = selectedCurrency?.rawValue {
            return currencyName
        } else {
            return NSLocalizedString("add-transaction-currency-placeholder")
        }
    }
    
    var selectedCategory: Category?
    var categoryPlaceholder: String {
        if let categoryName = selectedCategory?.name {
            return categoryName
        } else {
            return NSLocalizedString("add-transaction-category-placeholder")
        }
    }
    
    var selectedDate: Date = Date()
 
    // Currency id and name to forward the actions sheet
    var currenciesData: [(String, String)] {
        Currency.allCases.map { ($0.rawValue, $0.rawValue) } // same id and name for currencies
    }
    
    // Category id and name to forward the actions sheet
    var categoriesData: [(String, String)] {
        categories = categoryService.fetchCategories()
        return categories.map { ($0.id, $0.name) }
    }
    
    // MARK: -
    
    var shouldRefresh: (() -> Void)?
    
    var canSave: Bool {
        selectedCurrency != nil
            && selectedCategory != nil
            && selectedTitle != nil
            && selectedAmount != nil
    }
    
    func save() {
        guard let title = selectedTitle,
            let amount = selectedAmount,
            let currency = selectedCurrency,
            let category = selectedCategory
            else {
                Log.message("Can't save", level: .error, type: .transaction)
                return
        }
        let transaction = Transaction(
            id: "\(Date().timeIntervalSince1970)",
            title: title,
            amount: amount,
            currency: currency,
            category: category,
            date: selectedDate
        )
        Log.message("Saving transaction: \(transaction)", level: .info, type: .transaction)
        transactionService.saveTransaction(transaction)
    }
    
    // MARK: - User Interaction
    
    func didSelectCurrency(_ rawValue: String) {
        selectedCurrency = Currency(rawValue: rawValue)
        shouldRefresh?()
    }
    
    func didSelectCategory(_ id: String) {
        selectedCategory = categories.first(where: { $0.id == id })
        shouldRefresh?()
    }
    
    func didSelectdate(_ date: Date) {
        selectedDate = date
        shouldRefresh?()
    }
}
