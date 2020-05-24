//
//  CategoryDB+CoreDataClass.swift
//  Xpense
//
//  Created by Nestor Garcia on 23/05/2020.
//  Copyright © 2020 nestor. All rights reserved.
//
//

import Foundation
import CoreData


public class CategoryDB: NSManagedObject {

    func toCategory() -> Category? {
        guard let id = id, let name = name, let hex = hex else {
            Log.message("Could not create Category from CategoryDB", level: .error, type: .database)
            return nil
        }
        return Category(id: id, name: name, hex: hex)
    }
    
    @discardableResult
    static func createFromCategory(_ category: Category, context: NSManagedObjectContext) -> CategoryDB {
        let categoryDB = CategoryDB(context: context)
        categoryDB.id = category.id
        categoryDB.name = category.name
        categoryDB.hex = category.hex
        return categoryDB
    }
}
