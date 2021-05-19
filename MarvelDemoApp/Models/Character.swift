//
//  Character.swift
//  MarvelDemoApp
//
//  Created by Mario Rosales Maillo on 18/05/2021.
//

import Foundation

struct Character: Decodable {
    let id: Int?
    let name, description: String?
    let resourceURI: String?
    
    private let comics, series: Publications?
    private let thumbnail: Thumbnail?

    enum CodingKeys: String, CodingKey {
        case id, name
        case description, resourceURI, thumbnail
        case comics, series
    }
    
    public func getThumbnailPath() -> String? {
        
        guard let path = thumbnail?.path else { return nil }
        guard let fileExtension = thumbnail?.fileExtension else { return nil }
        return path + "." + fileExtension
    }
    
    public func getComics() -> [Publication]? {
        return comics?.items
    }
    
    public func getSeries() -> [Publication]? {
        return series?.items
    }
}
