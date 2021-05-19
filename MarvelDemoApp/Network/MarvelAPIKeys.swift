//
//  MarvelAPIKeys.swift
//  MarvelDemoApp
//
//  Created by Mario Rosales Maillo on 18/05/2021.
//

import Foundation
import CryptoKit

struct MarvelAPIKeys {
    
    static private let privateKey = "23ec56ac540c405b94063afddc79bcda1fcac842"
    static let publicKey = "ee77e6d97c8a8329dce2c8bff21d88c1"
    static let ts = String(Date().timeIntervalSince1970)
    
    static var md5: String {
        let digest = Insecure.MD5.hash(data: "\(ts)\(privateKey)\(publicKey)".data(using: .utf8) ?? Data())
        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
}
