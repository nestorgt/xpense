//
//  CurrencyLayerRepository.swift
//  Xpense
//
//  Created by Nestor Garcia on 19/05/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import Foundation

/// Respository responsible of getting data from Currency Layer API
protocol CurrencyLayerRepositoryProtocol {
    
    /// Get the conversion for a given currency pair.
    /// - Parameters:
    ///   - fromCurrency: Source of currency.
    ///   - toCurrency: Currency to which you want to know the conversion.
    ///   - amount: Amount of source of currency.
    ///   - date: Historical date of the quote.
    ///   - completion: A completiong block called with the response or the error that occurred.
    func getConversion(fromCurrency: Currency,
                       toCurrency: Currency,
                       amount: Double,
                       on date: Date,
                       completion: @escaping (Result<CurrencyLayerConvertResponse, RepositoryError>) -> Void)
}

final class CurrencyLayerRepository: CurrencyLayerRepositoryProtocol {
    
    private let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol = DI.apiService) {
        self.apiService = apiService
    }
    
    func getConversion(fromCurrency: Currency,
                       toCurrency: Currency,
                       amount: Double,
                       on date: Date,
                       completion: @escaping (Result<CurrencyLayerConvertResponse, RepositoryError>) -> Void) {
        guard let request = CurrencyLayerRouter
            .convert(fromCurrency: fromCurrency, toCurrency: toCurrency, amount: amount, on: date)
            else { completion(.failure(.wrongURLRequest)); return }
        apiService.perform(urlRequest: request) { result in
            switch result {
            case .success(let data):
                do {
                    let response = try JSONDecoder.xpense.decode(CurrencyLayerConvertResponse.self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(.decoderFailed))
                }
            case .failure(let error):
                completion(.failure(.apiError(error)))
            }
        }
    }
}
