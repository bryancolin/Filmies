//
//  Movies.swift
//  Filmies
//
//  Created by bryan colin on 7/9/21.
//

import Foundation

struct Films: Codable {
    var all: [Film]?
    
    enum CodingKeys: String, CodingKey {
        case all = "results"
    }
    
    init(from decoder: Decoder) throws {
        let container =  try decoder.container(keyedBy: CodingKeys.self)
        var results = try container.nestedUnkeyedContainer(forKey: CodingKeys.all)
        var films = [Film]()
        
        var array = results
        while(!results.isAtEnd) {
            let film = try results.nestedContainer(keyedBy: Film.CodingKeys.self)
            let title = try film.decodeIfPresent(String.self, forKey: Film.CodingKeys.title)
            films.append(try array.decode(title != nil ? Movie.self : TvShow.self))
        }
        
        self.all = films
    }
}

