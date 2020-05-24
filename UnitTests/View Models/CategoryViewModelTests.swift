//
//  CategoryViewModelTests.swift
//  UnitTests
//
//  Created by Nestor Garcia on 23/05/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import XCTest
@testable import Xpense

class CategoryViewModelTests: XCTestCase {

    var vm: CategoryViewModel!
    var categoryServiceMock: CategoryServiceMock!
    
    override func setUp() {
        super.setUp()
        categoryServiceMock = CategoryServiceMock()
        vm = CategoryViewModel(categoryService: categoryServiceMock)
    }
    
    func testIntialState_NoRows() {
        XCTAssertEqual(vm.screentTitle, NSLocalizedString("category-tab-title"))
        XCTAssertEqual(vm.alertDescription, NSLocalizedString("alert-category-description"))
        XCTAssertEqual(vm.alertTitle, NSLocalizedString("alert-category-title"))
        XCTAssertEqual(vm.alertHexPlaceholder, NSLocalizedString("alert-category-hex-placeholder"))
        XCTAssertEqual(vm.alertNamePlaceholder, NSLocalizedString("alert-category-name-placeholder"))
        XCTAssertEqual(vm.nameForSection(0), NSLocalizedString("category-section-title"))
        
        XCTAssertEqual(vm.numberOfSections, 1)
        XCTAssertEqual(vm.numberOfRowsInSection(0), 0)
        XCTAssertEqual(vm.numberOfRowsInSection(1), 0)
    }
    
    func testWithThreeCategories() {
        let c1 = CategoryMock.sampleRestaurant
        let c2 = CategoryMock.sampleFurniture
        let c3 = CategoryMock.sampleGambling
        categoryServiceMock.nextFetchCategories = [c1, c2, c3]

        vm.refresh()
        
        XCTAssertEqual(vm.numberOfSections, 1)
        XCTAssertEqual(vm.numberOfRowsInSection(0), 3)

        XCTAssertEqual(vm.name(for: 0), c1.name)
        XCTAssertEqual(vm.name(for: 1), c2.name)
        XCTAssertEqual(vm.name(for: 2), c3.name)

        XCTAssertEqual(vm.hexColor(for: 0), c1.hex)
        XCTAssertEqual(vm.hexColor(for: 1), c2.hex)
        XCTAssertEqual(vm.hexColor(for: 2), c3.hex)
    }

    func testWithThreeCategories_didEnter_NameAndHex() {
        let c1 = CategoryMock.sampleRestaurant
        let c2 = CategoryMock.sampleFurniture
        let c3 = CategoryMock.sampleGambling
        categoryServiceMock.nextFetchCategories = [c1, c2, c3]
        vm.refresh()
    
        let newName = "new name"
        let newHex = "#123456"
        let result = vm.didEnter(nameString: newName, hexString: newHex, forIndex: 0)
        
        XCTAssertTrue(result)
        
        categoryServiceMock.nextFetchCategories = [categoryServiceMock.savedCategory!, c2, c3]
        vm.refresh()

        XCTAssertEqual(vm.name(for: 0), categoryServiceMock.savedCategory!.name)
        XCTAssertEqual(vm.name(for: 1), c2.name)
        XCTAssertEqual(vm.name(for: 2), c3.name)

        XCTAssertEqual(vm.hexColor(for: 0), categoryServiceMock.savedCategory!.hex)
        XCTAssertEqual(vm.hexColor(for: 1), c2.hex)
        XCTAssertEqual(vm.hexColor(for: 2), c3.hex)
    }
}
