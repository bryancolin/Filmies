//
//  Images.swift
//  Filmies
//
//  Created by bryan colin on 8/1/21.
//

import Foundation

struct Images: Codable {
    let backdrops, posters: [ImageURL]?
    
    var postersCount: Int {
        if let posters = posters {
            return posters.count
        }
        return 0
    }
    
    enum CodingKeys: String, CodingKey {
        case backdrops
        case posters
    }
}
