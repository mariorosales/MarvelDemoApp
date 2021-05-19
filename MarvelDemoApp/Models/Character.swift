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
   // let modified: Date?
    let thumbnail: Thumbnail?
    let resourceURI: String?
  //  let comics, series: Comics?
  //  let stories: Stories?
  //  let events: Comics?
  //  let urls: [URLElement]?

    enum CodingKeys: String, CodingKey {
        case id, name
        case description, resourceURI, thumbnail
       // case modified, thumbnail, resourceURI, comics, series, stories, events, urls
    }
    
    public func getThumbnailPath() -> String? {
        
        guard let path = thumbnail?.path else { return nil }
        guard let fileExtension = thumbnail?.fileExtension else { return nil }
        return path + "." + fileExtension
    }
}
