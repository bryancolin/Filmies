//
//  Season.swift
//  Filmies
//
//  Created by bryan colin on 8/6/21.
//

import Foundation

struct Season: Codable, Identifiable {
    let id, number, totalEpisode: Int?
    let name, description, airDate, posterPath: String?
    
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
