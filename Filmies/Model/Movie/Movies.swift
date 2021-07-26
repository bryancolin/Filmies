//
//  Movies.swift
//  Filmies
//
//  Created by bryan colin on 7/9/21.
//

import Foundation

struct Movies: Codable {
    var all: [Movie]?
    
    enum CodingKeys: String, CodingKey {
        case all = "results"
    }
}
