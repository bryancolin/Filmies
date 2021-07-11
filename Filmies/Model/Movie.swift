//
//  Movie.swift
//  Filmies
//
//  Created by bryan colin on 7/9/21.
//

import Foundation

struct Movie: Codable, Identifiable {
    var id: Int
    var title: String
    var description: String
    var releaseDate: String
    var url: String 
    var imageURL: String {
        return "https://image.tmdb.org/t/p/w500" + url
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title = "original_title"
        case description = "overview"
        case releaseDate = "release_date"
        case url = "poster_path"
    }
}
