//
//  ApplicationConstants.swift
//  CurrencyConverter
//
//  Created by Armando Carmona on 24/10/2019.
//  Copyright (c) 2016, Happy Computer. All rights reserved.
//

import Foundation

struct ApplicationConstants {

    #if DEBUG // DEVELOPMENT
    static let endpoint: Environment = .development
    #elseif RELEASE // APPSTORE
    static let endpoint: Environment = .production
    #endif
    static let APIBaseURL = endpoint.baseURL
    static let APIVersion = endpoint.version
    static let APIPublicKey = endpoint.publicKey
    static let APISecretKey = endpoint.secretKey
}
