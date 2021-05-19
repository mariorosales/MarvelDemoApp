//
//  Thumbnail.swift
//  MarvelDemoApp
//
//  Created by Mario Rosales Maillo on 18/05/2021.
//

import Foundation

struct Thumbnail: Decodable {
    
    let path: String?
    let fileExtension: String?

    enum CodingKeys: String, CodingKey {
        case path
        case fileExtension = "extension"
    }
}
