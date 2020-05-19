//
//  Logger.swift
//  Xpense
//
//  Created by Nestor Garcia on 19/05/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import Foundation
import os.log

/// Class used to capture log messages in the app. Log messages are sent to Apple's unified logging system,
/// and can be viewed and filtered in the Console app.
final class Log {
    static var enabledLevels: Set<Log.Level> = [.error, .info, .debug]
    static var enabledCategories: Set<Log.Category> = [.decoder, .network, .other]
    
    static func message(_ message: Any?, level: Log.Level, category: Log.Category = .other) {
        guard enabledLevels.contains(level),
            enabledCategories.contains(category)
            else { return }
        os_log("%@",
               log: OSLog(subsystem: Bundle.main.bundleIdentifier ?? "",
                          category: category.description),
               type: level.oslogType,
               "\(message ?? "")")
    }
}

// MARK: - Enums

extension Log {
    
    /// Log levels supported.
    enum Level: String, CaseIterable {
        case error
        case info
        case debug
        
        var description: String {
            return "[\(rawValue.capitalized)]"
        }
        
        var oslogType: OSLogType {
            switch self {
            case .debug: return .debug
            case .info: return .info
            case .error: return .error
            }
        }
    }

    /// Categories refers to the different sections of the app that could potentially send logs.
    enum Category: String, CaseIterable {
        case decoder
        case network
        case other
        
        var description: String {
            if case self = Log.Category.other {
                return ""
            } else {
                return rawValue.capitalized
            }
        }
    }
}
