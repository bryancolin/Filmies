//
//  Videos.swift
//  Filmies
//
//  Created by bryan colin on 7/20/21.
//

import Foundation

struct Videos: Codable {
    let all: [Video]
    
    enum CodingKeys: String, CodingKey {
        case all = "results"
    }
}
