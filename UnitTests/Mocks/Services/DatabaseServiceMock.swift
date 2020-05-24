//
//  DatabaseServiceMock.swift
//  UnitTests
//
//  Created by Nestor Garcia on 24/05/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

@testable import Xpense

final class DatabaseServiceMock: DatabaseServiceProtocol {
    
    var nextFetchCategories: [Category] = []
    var savedCategories: [Category] = []
    var nextFetchTransactions: [Transaction] = []
    var savedTransactions: [Transaction] = []
    var savedAllCount = 0
    
    // MARK: - DatabaseServiceProtocol
    
    func fetchCategories() -> [Category] {
        nextFetchCategories
    }
    
    func saveCategory(_ category: Category) {
        savedCategories.append(category)
    }
    
    func fetchTransactions() -> [Transaction] {
        nextFetchTransactions
    }
    
    func saveTransaction(_ transaction: Transaction) {
        savedTransactions.append(transaction)
    }
    
    func saveAll() {
        savedAllCount += 1
    }
}
