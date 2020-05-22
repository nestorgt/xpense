//
//  APIServiceMock.swift
//  UnitTests
//
//  Created by Nestor Garcia on 22/05/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import Foundation
@testable import Xpense

final class APIServiceMock: APIServiceProtocol {
    
    var nextResult: Result<Data, APIError>?
    
    // MARK: - APIServiceProtocol
    
    func perform(urlRequest: URLRequest, completion: @escaping (Result<Data, APIError>) -> Void) {
        // simulate asynchronous request
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(50)) { [weak self] in
            guard let result = self?.nextResult else {
                completion(.failure(.generic(message: "nextResult is nil")))
                return
            }
            completion(result)
        }
    }
}
