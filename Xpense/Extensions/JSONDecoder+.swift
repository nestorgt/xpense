//
//  JSONDecoder+.swift
//  Xpense
//
//  Created by Nestor Garcia on 22/05/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import Foundation

extension JSONDecoder {

    /// Common json decoder to use for all repositories
    static var xpense: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dataDecodingStrategy = .base64
        decoder.dateDecodingStrategy = .deferredToDate
        decoder.nonConformingFloatDecodingStrategy = .throw
        return decoder
    }
}
