//
//  CurrencyLayerConvertResponseTests.swift
//  UnitTests
//
//  Created by Nestor Garcia on 21/05/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import XCTest
@testable import Xpense

class CurrencyLayerConvertResponseTests: XCTestCase {
    
    // MARK: - Tests

    func testDecoder_SuccessTrue() {
        let jsonString =
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
        let jsonData = TestHelper.JSONData(fromString: jsonString)
        let response = try! JSONDecoder().decode(CurrencyLayerConvertResponse.self, from: jsonData)
        
        XCTAssertTrue(response.success)
        XCTAssertEqual(response.query, CurrencyLayerConvertResponse.Query(from: "USD", to: "NZD", amount: 10))
        XCTAssertEqual(response.quote, 1.62974)
        XCTAssertEqual(response.date, Date.date(from: "2020-05-20"))
        XCTAssertEqual(response.result, 16.2974)
        XCTAssertNil(response.error)
    }
    
    func testDecoder_SuccessFalse() {
        let jsonString =
        """
        {
            "success": false,
            "error": {
                "code": 105,
                "info": "Access Restricted - Your current Subscription Plan does not support this API Function."
            }
        }
        """
        let jsonData = TestHelper.JSONData(fromString: jsonString)
        let response = try! JSONDecoder().decode(CurrencyLayerConvertResponse.self, from: jsonData)
        
        XCTAssertFalse(response.success)
        XCTAssertNil(response.query)
        XCTAssertNil(response.quote)
        XCTAssertNil(response.date)
        XCTAssertNil(response.result)
        XCTAssertEqual(response.error, CurrencyLayerConvertResponse.Error(
            code: 105,
            info: "Access Restricted - Your current Subscription Plan does not support this API Function.")
        )
    }
}
