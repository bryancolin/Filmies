//
//  Casts.swift
//  Filmies
//
//  Created by bryan colin on 7/23/21.
//

import Foundation

struct Casts: Codable {
    let cast: [Cast]?
    let crew: [Crew]?
    
    var crewCategories: [String: [Crew]] {
        if let crew = crew {
            return Dictionary(grouping: crew, by: { $0.job ?? "" })
        }
        return Dictionary()
    }
    
    enum CodingKeys: String, CodingKey {
        case cast
        case crew
    }
}
