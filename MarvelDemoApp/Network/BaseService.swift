//
//  BaseService.swift
//  MarvelDemoApp
//
//  Created by Mario Rosales Maillo on 18/05/2021.
//

import Combine
import UIKit

enum HTTPMethod: String {
    case GET
}

struct BaseService {
    
    func send<T: Decodable>(_ request: URLRequest, _ decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<T, ServiceError> {
        return URLSession.shared.dataTaskPublisher(for: request)
            .mapError{ ServiceError.server(code: $0.errorCode, message: $0.localizedDescription) }
            .map { $0.data }
            .decode(type: T.self, decoder: decoder)
            .print()
            .mapError { _ in ServiceError.decoding}
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func send(_ request: URLRequest) -> AnyPublisher<Data, URLError> {
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

