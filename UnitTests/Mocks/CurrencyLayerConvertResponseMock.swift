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
    
    static let sample = try! JSONDecoder.xpense.decode(CurrencyLayerConvertResponse.self, from: sampleData)
    
    static func sampleJSONString() -> String {
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
    }
    
    static var sampleData: Data {
        TestHelper.JSONData(fromString: sampleJSONString())
    }
}
