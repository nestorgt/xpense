//
//  CategoryServiceTests.swift
//  UnitTests
//
//  Created by Nestor Garcia on 24/05/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import XCTest
@testable import Xpense

class CategoryServiceTests: XCTestCase {

    var categoryService: CategoryServiceProtocol!
    var databaseServiceMock: DatabaseServiceMock!
    
    override func setUp() {
        super.setUp()
        databaseServiceMock = DatabaseServiceMock()
        categoryService = CategoryService(databaseService: databaseServiceMock)
    }

    func testFetchCategories_CreatesDefaultOnes() {
        databaseServiceMock.nextFetchCategories = []
        
        _ = categoryService.fetchCategories()
        
        XCTAssertEqual(databaseServiceMock.savedCategories.count, 6)
    }
    
    func testFetchCategories_UsesDatabase() {
        databaseServiceMock.nextFetchCategories = [CategoryMock.sampleBills]
        
        let result = categoryService.fetchCategories()
        
        XCTAssertEqual(databaseServiceMock.savedCategories.count, 0)
        XCTAssertEqual(result.count, 1)
    }
    
    func testSaveCategories() {
        let category = CategoryMock.sampleBills
        
        categoryService.save(category: category)
        
        XCTAssertEqual(databaseServiceMock.savedCategories, [category])
    }
}
