//
//  TestHelpers.swift
//  UnitTests
//
//  Created by Nestor Garcia on 21/05/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import Foundation

struct TestHelper {
    
    static func JSONData(fromString string: String) -> Data {
        return string.data(using: .utf8)!
    }
}
