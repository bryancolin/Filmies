//
//  Movies.swift
//  Filmies
//
//  Created by bryan colin on 7/9/21.
//

import Foundation

struct Movies: Codable {
    let all: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case all = "results"
    }
}
