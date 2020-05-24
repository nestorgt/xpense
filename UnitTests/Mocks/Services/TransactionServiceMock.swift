//
//  TransactionServiceMock.swift
//  UnitTests
//
//  Created by Nestor Garcia on 24/05/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

@testable import Xpense

final class TransactionServiceMock: TransactionServiceProtocol {
    
    var nextFetchTransactions: [Transaction] = []
    var savedTransaction: Transaction?
    var updatedConversion: (amount: String, currency: String, id: String)?
    
    // MARK: - APIServiceProtocol
    
    func fetchTransactions() -> [Transaction] {
        nextFetchTransactions
    }
    
    func save(transaction: Transaction) {
        savedTransaction = transaction
    }
    
    func updateConversion(amount: String, currency: String, on transactionId: String) {
        updatedConversion = (amount, currency, transactionId)
    }
}
