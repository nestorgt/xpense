//
//  DatabaseService.swift
//  Xpense
//
//  Created by Nestor Garcia on 23/05/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import Foundation
import CoreData

protocol DatabaseServiceProtocol {
    
    /// Fetch all categories from DB. Will create default ones if none is found.
    func fetchCategories() -> [Category]
    
    /// Create or update a category
    func saveCategory(_ category: Category)
    
    /// Save all pending objects into the DB
    func saveAll()
}

final class DatabaseService: DatabaseServiceProtocol {
    
    private var categories: [Category] = []
    
    // MARK: - DatabaseServiceProtocol
    
    func fetchCategories() -> [Category] {
        do {
            let categoriesDB: [CategoryDB] = try context.fetch(CategoryDB.fetchRequest())
            categories = categoriesDB.compactMap { $0.toCategory() }
            Log.message("Found \(categoriesDB.count) categories", level: .info, category: .database)
        } catch let error as NSError {
            Log.message("Could not fetch categories: \(error) - \(error.userInfo)", level: .error, category: .database)
        }
        return categories
    }
    
    func saveCategory(_ category: Category) {
        updateCategoryDB(from: category)
    }
    
    func saveAll() {
        Log.message("Saving context", level: .info, category: .database)
        saveContext()
    }
    
    // MARK: - Core Data stack

    private lazy var context = persistentContainer.viewContext
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Xpense")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                Log.message("Can't load persistent stores", level: .error, category: .database)
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support

    private func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch let error as NSError {
                Log.message("Can't save into Database", level: .error, category: .database)
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}

// MARK: - Private

private extension DatabaseService {
    
    func updateCategoryDB(from category: Category) {
        let request = CategoryDB.fetchRequest() as NSFetchRequest<CategoryDB>
        request.predicate = NSPredicate(format: "id == %@", category.id)
        var categoriesDB = [CategoryDB]()
        do {
            categoriesDB = try context.fetch(request)
        } catch let error as NSError {
            Log.message("Can't find into Database: \(error), \(error.userInfo)", level: .error, category: .database)
        }
        
        if let categoryDB = categoriesDB.first {
            Log.message("Updating DB entry \(category.id)", level: .info, category: .database)
            categoryDB.name = category.name
            categoryDB.hex = category.hex
        } else {
            Log.message("Creating DB entry \(category.id)", level: .info, category: .database)
            CategoryDB.createFromCategory(category, insertInto: context)
        }
    }
}
