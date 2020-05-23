//
//  CategoryServiceMock.swift
//  UnitTests
//
//  Created by Nestor Garcia on 23/05/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

@testable import Xpense

final class CategoryServiceMock: CategoryServiceProtocol {
    
    var nextFetchCategories: [Category] = []
    var savedCategory: Category?
    
    // MARK: - APIServiceProtocol
    
    func fetchCategories() -> [Category] {
        nextFetchCategories
    }
    
    func save(category: Category) {
        savedCategory = category
    }
}
