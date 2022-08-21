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
}

extension Casts {
    var crewCategories: [String: [Crew]] {
        guard let crew = crew else { return Dictionary() }
        return Dictionary(grouping: crew, by: { $0.job ?? "" })
    }
}
