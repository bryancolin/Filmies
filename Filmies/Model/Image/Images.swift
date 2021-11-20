//
//  Images.swift
//  Filmies
//
//  Created by bryan colin on 8/1/21.
//

import Foundation

struct Images: Codable {
    let backdrops, posters: [Photo]?
    
    enum CodingKeys: String, CodingKey {
        case backdrops
        case posters
    }
}
