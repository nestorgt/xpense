//
//  APIService.swift
//  Xpense
//
//  Created by Nestor Garcia on 19/05/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import Foundation
import UIKit

protocol APIServiceProtocol {
    func perform(urlRequest: URLRequest, completion: @escaping (Result<Data, APIError>) -> Void)
}

final class APIService: APIServiceProtocol {
    
    private let urlSession: URLSession
    
    // MARK: Lifecycle
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    // MARK: Requests
    
    func perform(urlRequest: URLRequest, completion: @escaping (Result<Data, APIError>) -> Void) {
        Log.message(urlRequest.url?.absoluteString, level: .info, category: .network)
        urlSession.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                Log.message("Request error: \(error.localizedDescription)", level: .error, category: .network)
                completion(.failure(.generic(message: error.localizedDescription)))
            } else if let response = response as? HTTPURLResponse, let data = data {
                if let apiError = APIError.error(from: response.statusCode) {
                    Log.message("Request response code: \(response.statusCode)", level: .error, category: .network)
                    completion(.failure(apiError))
                } else {
                    Log.message("Request OK: \(response.statusCode)", level: .info, category: .network)
                    completion(.success(data))
                }
            } else {
                Log.message("Request Error: no response/data", level: .error, category: .network)
                completion(.failure(.generic(message: "no response/data")))
            }
        }.resume()
    }
}
