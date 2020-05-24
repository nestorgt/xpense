//
//  TransactionService.swift
//  Xpense
//
//  Created by Nestor Garcia on 24/05/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import Foundation

protocol TransactionServiceProtocol {
    
    /// Fetch all trasanctions.
    func fetchTransactions() -> [Transaction]
    
    /// Saves or updates a transaction
    /// - Parameter transaction: the transaction to be saved.
    func save(transaction: Transaction)
    
    
    /// Updates the conversion amount of the Transaction to the given values.
    /// - Parameters:
    ///   - amount: New amount to save.
    ///   - currency: New currency to save.
    ///   - transactionId: The transaction id to be modified (must exist on DB).
    func updateConversion(amount: String, currency: String, on transactionId: String)
}

final class TransactionService: TransactionServiceProtocol {
    
    private let databaseService: DatabaseServiceProtocol
    private var transactions: [Transaction] = []
    
    init(databaseService: DatabaseServiceProtocol = DI.databaseService) {
        self.databaseService = databaseService
    }
    
    func fetchTransactions() -> [Transaction] {
        transactions = databaseService.fetchTransactions()
        #if DEBUG
        if transactions.isEmpty {
            Log.message("Creating and storing default transactions...", level: .info, type: .category)
            mockTransactions().forEach { [weak self] in
                self?.databaseService.saveTransaction($0)
            }
            transactions = databaseService.fetchTransactions()
        }
        #endif
        return transactions
    }
    
    func save(transaction: Transaction) {
        databaseService.saveTransaction(transaction)
    }
    
    func updateConversion(amount: String, currency: String, on transactionId: String) {
        Log.message("Saving conversion amount for \(transactionId): \(currency) \(amount)", level: .info, type: .transaction)
        guard var transaction = transactions.first(where: { $0.id == transactionId }) else {
            Log.message("Saving conversion failed", level: .error, type: .transaction)
            return
        }
        transaction.convertedAmount = amount
        transaction.convertedCurrency = Currency(rawValue: currency)
        databaseService.saveTransaction(transaction)
    }
}

// MARK: - Private

private extension TransactionService {
    
    func mockTransactions() -> [Transaction] {
        [TransactionMock.sample6, TransactionMock.sample4, TransactionMock.sample5,
            TransactionMock.sample2, TransactionMock.sample3, TransactionMock.sample1]
    }
}
