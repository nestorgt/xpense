//
//  TransactionDB+CoreDataClass.swift
//  Xpense
//
//  Created by Nestor Garcia on 24/05/2020.
//  Copyright © 2020 nestor. All rights reserved.
//
//

import Foundation
import CoreData

public class TransactionDB: NSManagedObject {

    func toTransaction() -> Transaction? {
        guard let id = id,
            let currencyValue = currency,
            let currency = Currency(rawValue: currencyValue),
            let title = title,
            let category = category?.toCategory(),
            let date = date else {
                Log.message("Could not create Transaction from TransactionDB", level: .error, type: .database)
                return nil
        }
        return Transaction(id: id,
                           title: title,
                           amount: amount,
                           currency: currency,
                           category: category,
                           date: date,
                           convertedCurrency: Currency(rawValue: convertedCurrency ?? ""),
                           convertedAmount: convertedAmount)
    }
    
    static func createFromTransaction(_ transaction: Transaction, context: NSManagedObjectContext) {
        let transactionDB = TransactionDB(context: context)
        transactionDB.id = transaction.id
        transactionDB.title = transaction.title
        transactionDB.amount = transaction.amount
        transactionDB.currency = transaction.currency.rawValue
        transactionDB.date = transaction.date
        transactionDB.convertedCurrency = transaction.convertedCurrency?.rawValue
        transactionDB.convertedAmount = transaction.convertedAmount
        
        // Fing the Category in the DB
        let request = CategoryDB.fetchRequest() as NSFetchRequest<CategoryDB>
        request.predicate = NSPredicate(format: "id == %@", transaction.category.id)
        let result = (try? context.fetch(request))?.first
        transactionDB.category = result
    }
}
