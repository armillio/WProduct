//
//  Environments.swift
//  CurrencyConverter
//
//  Created by Armando Carmona on 24/10/2019.
//  Copyright (c) 2016, Happy Computer. All rights reserved.
//

import Foundation

enum Environment {
    case development
    case production

    var description: String {
        switch self {
        case .development:
            return "Development"
        case .production:
            return "Production"
        }
    }

    var baseURL: String {
        switch self {
        case .development:
            return ""
        case .production:
            return ""
        }
    }

    var version: String {
        return "1.0"
    }

    var publicKey: String {
        switch self {
        case .development:
            return ""
        case .production:
            return ""
        }
    }

    var secretKey: String {
        switch self {
        case .development:
            return ""
        case .production:
            return ""
        }
    }
}
