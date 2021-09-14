//
//  Credits.swift
//  Filmies
//
//  Created by bryan colin on 9/1/21.
//

import Foundation

struct Credits: Codable {
    let all: [Film]?
    
    enum CodingKeys: String, CodingKey {
        case all = "cast"
    }
    
    enum CodingNameKey: CodingKey {
        case title
    }
    
    init(from decoder: Decoder) throws {
        let container =  try decoder.container(keyedBy: CodingKeys.self)
        var results = try container.nestedUnkeyedContainer(forKey: CodingKeys.all)
        var films = [Film]()
        
        var result = results
        while(!results.isAtEnd)
        {
            let film = try results.nestedContainer(keyedBy: CodingNameKey.self)
            let title = try film.decodeIfPresent(String.self, forKey: CodingNameKey.title)
            films.append(try result.decode(title != nil ? Movie.self : TvShow.self))
        }
        
        self.all = films
    }
}
