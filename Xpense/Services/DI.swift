//
//  DI.swift
//  Xpense
//
//  Created by Nestor Garcia on 22/05/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import Foundation

let DI = DependencyInjector.shared // quick accessor

/// Dependency injector to share common components across the App.
protocol DependencyInjectorProtocol {
    
    var apiService: APIServiceProtocol { get }
    var currencyLayerRepository: CurrencyLayerRepository? { get }
}

final class DependencyInjector {
    
    static let shared = DependencyInjector() // singleton

    lazy var apiService: APIServiceProtocol = APIService()
    lazy var currencyLayerRepository: CurrencyLayerRepositoryProtocol = {
        return CurrencyLayerRepository(apiService: apiService)
    }()
        
    private init() { }
}
