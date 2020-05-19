//
//  APIError.swift
//  Xpense
//
//  Created by Nestor Garcia on 19/05/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import Foundation

enum APIError: Error {
    case decoder
    case badRequest
    case notFound
    case generic(message: String?)
    
    static func error(from httpCode: Int) -> APIError? {
        guard httpCode != 200 else { return nil }
        switch httpCode {
        case 400:
            return .badRequest
        case 404:
            return .notFound
        default:
            return .generic(message: "\(httpCode)")
        }
    }
    
    var errorMessage: String {
        return NSLocalizedString("api-error-generic")
    }
}
