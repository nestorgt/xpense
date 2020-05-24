//
//  TransactionMock.swift
//  UnitTests
//
//  Created by Nestor Garcia on 24/05/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import UIKit

struct TransactionMock {
    
    static var sample1: Transaction {
        Transaction(id: "tx1",
                    title: "Desigual Barcelona",
                    amount: 29.99,
                    currency: .EUR,
                    category: CategoryMock.sampleClothing,
                    date: Date.date(from: "2020-01-01")!)
    }
    
    static var sample2: Transaction {
        Transaction(id: "tx2",
                    title: "Mango Barcelona",
                    amount: 19.99,
                    currency: .EUR,
                    category: CategoryMock.sampleClothing,
                    date: Date.date(from: "2020-01-01")!)
    }
    
    static var sample3: Transaction {
        Transaction(id: "tx3",
                    title: "Calvin Klein Barcelona",
                    amount: 9.99,
                    currency: .EUR,
                    category: CategoryMock.sampleClothing,
                    date: Date.date(from: "2020-01-01")!)
    }
    
    static var sample4: Transaction {
        Transaction(id: "tx4",
                    title: "Consum Valencia",
                    amount: 1.99,
                    currency: .EUR,
                    category: CategoryMock.sampleGroceries,
                    date: Date.date(from: "2020-02-01")!)
    }
    
    static var sample5: Transaction {
        Transaction(id: "tx5",
                    title: "DIA Barcelona",
                    amount: 3.99,
                    currency: .EUR,
                    category: CategoryMock.sampleGroceries,
                    date: Date.date(from: "2020-02-02")!)
    }
    
    static var sample6: Transaction {
        Transaction(id: "tx6",
                    title: "Froiz Madrid",
                    amount: 4.99,
                    currency: .EUR,
                    category: CategoryMock.sampleGroceries,
                    date: Date.date(from: "2020-02-03")!)
    }
}
