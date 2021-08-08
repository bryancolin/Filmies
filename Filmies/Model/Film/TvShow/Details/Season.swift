//
//  Season.swift
//  Filmies
//
//  Created by bryan colin on 8/6/21.
//

import Foundation

struct Season: Codable, Identifiable {
    let id: Int?
    let name, description, airDate: String?
    let number, totalEpisode: Int?

    let posterPath: String?
    var posterUrl: String {
        if let url = posterPath {
            return String("https://image.tmdb.org/t/p/w500" + url)
        }
        return String()
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description = "overview"
        case number = "season_number"
        case airDate = "air_date"
        case totalEpisode = "episode_count"
        case posterPath = "poster_path"
    }
}
