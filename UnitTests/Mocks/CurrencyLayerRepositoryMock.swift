//
//  CurrencyLayerRepositoryMock.swift
//  UnitTests
//
//  Created by Nestor Garcia on 22/05/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import Foundation
@testable import Xpense

final class CurrencyLayerRepositoryMock: CurrencyLayerRepositoryProtocol {

    var nextResult: Result<CurrencyLayerConvertResponse, RepositoryError>?
    
    // MARK: - CurrencyLayerRepositoryProtocol
    
    func getConversion(fromCurrency: Currency,
                       toCurrency: Currency,
                       amount: Double,
                       on date: Date,
                       completion: @escaping (Result<CurrencyLayerConvertResponse, RepositoryError>) -> Void) {
        // simulate asynchronous request
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(50)) { [weak self] in
            guard let result = self?.nextResult else {
                completion(.failure(.apiError(.generic(message: "nextResult is nil"))))
                return
            }
            completion(result)
        }
    }
}
