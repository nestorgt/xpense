//
//  TransactionDB+CoreDataProperties.swift
//  Xpense
//
//  Created by Nestor Garcia on 24/05/2020.
//  Copyright © 2020 nestor. All rights reserved.
//
//

import Foundation
import CoreData


extension TransactionDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TransactionDB> {
        return NSFetchRequest<TransactionDB>(entityName: "TransactionDB")
    }

    @NSManaged public var amount: Double
    @NSManaged public var currency: String?
    @NSManaged public var date: Date?
    @NSManaged public var id: String?
    @NSManaged public var convertedAmount: String?
    @NSManaged public var title: String?
    @NSManaged public var convertedCurrency: String?
    @NSManaged public var category: CategoryDB?

}
