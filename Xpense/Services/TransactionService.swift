//
//  TransactionService.swift
//  Xpense
//
//  Created by Nestor Garcia on 24/05/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import Foundation

protocol TransactionServiceProtocol {
    
    func saveTransaction(_ transaction: Transaction)
}

final class TransactionService: TransactionServiceProtocol {
    
    private let databaseService: DatabaseServiceProtocol
    
    init(databaseService: DatabaseServiceProtocol = DI.databaseService) {
        self.databaseService = databaseService
    }
    
    func saveTransaction(_ transaction: Transaction) {
        databaseService.saveTransaction(transaction)
    }
}
