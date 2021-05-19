//
//  Publications.swift
//  MarvelDemoApp
//
//  Created by Mario Rosales Maillo on 19/05/2021.
//

import Foundation

struct Publications: Decodable {
    
    let available: Int?
    let collectionURI: String?
    let items: [Publication]?
    let returned: Int?
}
