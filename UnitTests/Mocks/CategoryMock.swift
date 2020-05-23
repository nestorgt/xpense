//
//  CategoryMock.swift
//  UnitTests
//
//  Created by Nestor Garcia on 23/05/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

@testable import Xpense

struct CategoryMock {

    static var sample1: Category {
        Category(id: "sjdljsl", name: "Bills", hex: "#010101")
    }
    
    static var sample2: Category {
        Category(id: "u4nf983", name: "Food", hex: "#AFAFAF")
    }
    
    static var sample3: Category {
        Category(id: "asd234f", name: "Services", hex: "#A0F1A0")
    }
}
