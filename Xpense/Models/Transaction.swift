//
//  Transaction.swift
//  Xpense
//
//  Created by Nestor Garcia on 24/05/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import Foundation

struct Transaction: Equatable {
    var id: String
    var title: String
    var amount: Double
    var currency: Currency
    var category: Category
    var date: Date
    var convertedCurrency: Currency? = nil
    var convertedAmount: String? = nil
}
