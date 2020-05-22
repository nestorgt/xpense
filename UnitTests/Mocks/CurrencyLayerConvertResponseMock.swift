//
//  CurrencyLayerConvertResponseMock.swift
//  UnitTests
//
//  Created by Nestor Garcia on 22/05/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import Foundation
@testable import Xpense

struct CurrencyLayerConvertResponseMock {
    
    static let sample = CurrencyLayerConvertResponse(
        success: true,
        query: CurrencyLayerConvertResponse.Query(from: "USD", to: "NZD", amount: 10),
        quote: 1.62974,
        date: Date(),
        result: 16.2974,
        error: nil
    )
    
    static func sampleData() -> Data {
        TestHelper.JSONData(fromString:
            """
            {
                "success": true,
                "terms": "https://currencylayer.com/terms",
                "privacy": "https://currencylayer.com/privacy",
                "query": {
                    "from": "USD",
                    "to": "NZD",
                    "amount": 10
                },
                "info": {
                    "timestamp": 1589995386,
                    "quote": 1.62974
                },
                "historical": true,
                "date": "2020-05-20",
                "result": 16.2974
            }
            """
        )
    }
}
