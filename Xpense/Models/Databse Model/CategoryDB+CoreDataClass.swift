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
            Log.message("Could not create Category from CategoryDB", level: .error, category: .database)
            return nil
        }
        return Category(id: id, name: name, hex: hex)
    }
    
    static func createFromCategory(_ category: Category, insertInto context: NSManagedObjectContext) {
        let categoryDB = CategoryDB(entity: CategoryDB.entity(), insertInto: context)
        categoryDB.id = category.id
        categoryDB.name = category.name
        categoryDB.hex = category.hex
    }
}
