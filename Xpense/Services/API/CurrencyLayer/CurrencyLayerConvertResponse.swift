//
//  CurrencyLayerConvertResponse.swift
//  Xpense
//
//  Created by Nestor Garcia on 21/05/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import Foundation

struct CurrencyLayerConvertResponse: Equatable {
    let success: Bool
    let query: Query?
    let quote: Double?
    let date: Date?
    let result: Double?
    let error: CurrencyLayerConvertResponse.Error?
    
    struct Query: Decodable, Equatable {
        let from: String
        let to: String
        let amount: Double
        
        var fromCurrency: Currency? {
            Currency(rawValue: from)
        }
        
        var toCurrency: Currency? {
            Currency(rawValue: to)
        }
    }
    
    struct Error: Decodable, Equatable {
        let code: Int
        let info: String
    }
}
    
extension CurrencyLayerConvertResponse: Decodable {
    
    // MARK: - Decodable
    
    public init(from decoder: Decoder) throws {
        let keyedContainer = try decoder.container(keyedBy: CodingKeys.self)
        success = try keyedContainer.decode(Bool.self, forKey: .success)
        query = try? keyedContainer.decodeIfPresent(Query.self, forKey: .query)
        let infoKeyedContainer = try? keyedContainer.nestedContainer(keyedBy: InfoCodingKeys.self, forKey: .info)
        quote = try? infoKeyedContainer?.decodeIfPresent(Double.self, forKey: .quote)
        if let dateString = try? keyedContainer.decodeIfPresent(String.self, forKey: .date) {
            guard let date = Date.date(from: dateString) else {
                throw DecodingError.dataCorruptedError(
                    forKey: .date,
                    in: keyedContainer,
                    debugDescription: "Can't create a date from string: \(dateString)"
                )
            }
            self.date = date
        } else {
            date = nil
        }
        result = try? keyedContainer.decodeIfPresent(Double.self, forKey: .result)
        error = try? keyedContainer.decodeIfPresent(CurrencyLayerConvertResponse.Error.self, forKey: .error)
    }
    
    enum CodingKeys: String, CodingKey {
        case success, query, info, date, result, error
    }
    
    enum InfoCodingKeys: String, CodingKey {
        case quote
    }
}
