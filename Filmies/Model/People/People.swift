//
//  People.swift
//  Filmies
//
//  Created by bryan colin on 9/1/21.
//

import Foundation

struct People: Codable, Identifiable {
    let id: Int?
    let name, biography, birthPlace, birthday, deathday, department, profilePath: String?
    
    let movieCredits, tvCredits: Credits?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case biography
        case birthPlace = "place_of_birth"
        case birthday
        case deathday
        case department = "known_for_department"
        case profilePath = "profile_path"
        
        case movieCredits = "movie_credits"
        case tvCredits = "tv_credits"
    }
}
