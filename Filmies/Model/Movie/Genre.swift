//
//  Genre.swift
//  Filmies
//
//  Created by bryan colin on 7/24/21.
//

import Foundation

struct Genre: Codable, Identifiable {
    let id: Int?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}
