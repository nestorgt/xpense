//
//  CategoryDB+CoreDataProperties.swift
//  Xpense
//
//  Created by Nestor Garcia on 23/05/2020.
//  Copyright © 2020 nestor. All rights reserved.
//
//

import Foundation
import CoreData


extension CategoryDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoryDB> {
        return NSFetchRequest<CategoryDB>(entityName: "CategoryDB")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var hex: String?

}
