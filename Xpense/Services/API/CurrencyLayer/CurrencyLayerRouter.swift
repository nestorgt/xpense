//
//  CurrencyLayerRouter.swift
//  Xpense
//
//  Created by Nestor Garcia on 19/05/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import Foundation

struct CurrencyLayerRouter {
    
    private static let apiKey = "54f81b1ae2ca835abf6603e808f8f154"
    private static let scheme = "https"
    private static let host = "api.currencylayer.com"
    private static let convertPath = "/convert"
    private static let dateFormat = "yyyy-MM-dd"
    private static let timeoutInterval = 30.0
    
    /// Returns an URLRequest for the conversion amount of two currencies on a given date.
    /// - Parameters:
    ///   - fromCurrency: Source of currency.
    ///   - toCurrency: Currency to which you want to know the conversion.
    ///   - date: Historical date of the quote.
    static func convert(fromCurrency: Currency, toCurrency: Currency, amount: Double, on date: Date = Date()) -> URLRequest? {
        var components = commonComponents
        components.path = Self.convertPath
        components.queryItems = commonQueryItems
            + [URLQueryItem(name: "from", value: fromCurrency.rawValue),
               URLQueryItem(name: "to", value: toCurrency.rawValue),
               URLQueryItem(name: "amount", value: "\(amount)"),
               URLQueryItem(name: "date", value: date.string(format: Self.dateFormat))]
        
        guard let url = components.url else { return nil }
        var urlRequest = URLRequest(url: url,
                                    cachePolicy: .useProtocolCachePolicy,
                                    timeoutInterval: Self.timeoutInterval)
        urlRequest.httpMethod = "GET"
        return urlRequest
    }
    
    private static var commonComponents: URLComponents {
        var components = URLComponents()
        components.scheme = Self.scheme
        components.host = Self.host
        return components
    }
    
    private static var commonQueryItems: [URLQueryItem] {
        [URLQueryItem(name: "access_key", value: Self.apiKey)]
    }
}
