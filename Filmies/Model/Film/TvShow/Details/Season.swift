//
//  Season.swift
//  Filmies
//
//  Created by bryan colin on 8/6/21.
//

import Foundation

struct Season: Codable, Identifiable {
    let id, number, totalEpisode: Int?
    let name, overview, airDate, posterPath: String?
    var episodes: [Episode]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case number = "season_number"
        case totalEpisode = "episode_count"
        case name
        case overview
        case airDate = "air_date"
        case posterPath = "poster_path"
        case episodes
    }
}
