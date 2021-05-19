//
//  Characters.swift
//  MarvelDemoApp
//
//  Created by Mario Rosales Maillo on 18/05/2021.
//

import Foundation

struct Characters: Decodable {
    let code: Int?
    let status: String?
    let copyright: String?
    let attributionText: String?
    let attributionHTML: String?
    let etag: String?
    private var data: CharacterDataContainer?
    
    public func characters() -> [Character]? {
        return data?.results
    }
    
    public func total() -> Int {
        return data?.total ?? 0
    }
    
    public func count() -> Int {
        return data?.count ?? 0
    }
}

struct CharacterDataContainer: Decodable {
    let offset, limit, total, count: Int?
    var results: [Character]?
}
