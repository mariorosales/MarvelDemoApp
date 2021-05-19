//
//  ServiceError.swift
//  MarvelDemoApp
//
//  Created by Mario Rosales Maillo on 18/05/2021.
//

public enum ServiceError: Error {
    case decoding
    case server(code: Int, message: String)
}
