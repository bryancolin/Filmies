//
//  Episode.swift
//  Filmies
//
//  Created by bryan colin on 1/20/22.
//

import Foundation

struct Episode: Codable, Identifiable {
    let id, number: Int?
    let name, overview: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case number = "episode_number"
        case name
        case overview
    }
}
