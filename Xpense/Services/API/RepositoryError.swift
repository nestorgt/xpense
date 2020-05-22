//
//  RepositoryError.swift
//  Xpense
//
//  Created by Nestor Garcia on 22/05/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import Foundation

/// Possible Respository errors returned by the any Repository.
enum RepositoryError: Error, Equatable {
    case apiError(APIError)
    case wrongURLRequest
    case decoderFailed
}
