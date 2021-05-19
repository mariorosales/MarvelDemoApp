//
//  MarvelService.swift
//  MarvelDemoApp
//
//  Created by Mario Rosales Maillo on 18/05/2021.
//

import UIKit
import Combine

public enum MarvelService {
    
    static let service = BaseService()
    
    private struct Config {
        static let pageSize:Int = 30
    }
    
    static func character(id: Int) -> AnyPublisher<Characters, ServiceError> {
        return send(URL.charactersEndpoint(id.toString(), limit: 1, offset: 0), method: .GET)
    }
    
    static func characters(page: Int = 0, searchString: String? = nil) -> AnyPublisher<Characters, ServiceError> {
        
        let pageNumber = (page < 0 ? 0 : page)
        return send(URL.charactersEndpoint(searchString: searchString, limit: Config.pageSize, offset: (pageNumber * Config.pageSize)), method: .GET)
    }

    static func create(for url: URL, method: HTTPMethod) -> URLRequest {

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = ["Content-Type": "application/json"]
        
        return request
    }
    
    static func send<T: Decodable>(_ url: URL, method: HTTPMethod) -> AnyPublisher<T, ServiceError> {
        let request = create(for: url, method: method)
        return service.send(request)
    }
}
