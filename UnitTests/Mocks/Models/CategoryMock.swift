//
//  CategoryMock.swift
//  UnitTests
//
//  Created by Nestor Garcia on 23/05/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

struct CategoryMock {
    
    static var sampleClothing: Category {
        Category(id: CategoryType.clothing.rawValue,
                 name: CategoryType.clothing.defaultName,
                 hex: CategoryType.clothing.defaultHexColor)
    }
    
    static var sampleGroceries: Category {
        Category(id: CategoryType.groceries.rawValue,
                 name: CategoryType.groceries.defaultName,
                 hex: CategoryType.groceries.defaultHexColor)
    }
    
    static var sampleBills: Category {
        Category(id: CategoryType.bills.rawValue,
                 name: CategoryType.bills.defaultName,
                 hex: CategoryType.bills.defaultHexColor)
    }
    
    static var sampleRestaurant: Category {
        Category(id: CategoryType.restaurant.rawValue,
                 name: CategoryType.restaurant.defaultName,
                 hex: CategoryType.restaurant.defaultHexColor)
    }
    
    static var sampleGambling: Category {
        Category(id: CategoryType.gambling.rawValue,
                 name: CategoryType.gambling.defaultName,
                 hex: CategoryType.gambling.defaultHexColor)
    }
    
    static var sampleFurniture: Category {
        Category(id: CategoryType.furniture.rawValue,
                 name: CategoryType.furniture.defaultName,
                 hex: CategoryType.furniture.defaultHexColor)
    }
}
