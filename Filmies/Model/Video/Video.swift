//
//  Video.swift
//  Filmies
//
//  Created by bryan colin on 7/20/21.
//

import Foundation

struct Video: Codable {
    let name, key, site, type: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case key
        case site
        case type
    }
}
