//
//  URL+Marvel.swift
//  MarvelDemoApp
//
//  Created by Mario Rosales Maillo on 18/05/2021.
//

import Foundation

extension URL {
    
    static private let baseURL = "https://gateway.marvel.com/"
    
    private enum Path:String {
        case characters = "v1/public/characters"
    }
    
    private enum QueryKey:String {
        case key = "apikey"
        case hash = "hash"
        case ts = "ts"
        case limit = "limit"
        case offset = "offset"
        case search = "nameStartsWith"
    }
        
    static func charactersEndpoint(_ id: String? = nil, searchString: String? = nil, limit: Int, offset: Int) -> URL {
        
        var endpoint = baseURL.append(pathComponent: Path.characters.rawValue)
        
        if let characterId = id {
            endpoint = endpoint.append(pathComponent: characterId)
        }
        
        if let search = searchString {
            endpoint.addQueryParameter(key: QueryKey.search, value: search)
        }
        
        endpoint.addQueryParameter(key: QueryKey.limit, value: limit)
        endpoint.addQueryParameter(key: QueryKey.offset, value: offset)
        endpoint.addQueryParameter(key: QueryKey.key, value: MarvelAPIKeys.publicKey)
        endpoint.addQueryParameter(key: QueryKey.hash, value: MarvelAPIKeys.md5)
        endpoint.addQueryParameter(key: QueryKey.ts, value: MarvelAPIKeys.ts)
        return URL(string: endpoint)!
    }
}
