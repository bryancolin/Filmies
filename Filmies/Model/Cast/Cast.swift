//
//  Cast.swift
//  Filmies
//
//  Created by bryan colin on 7/23/21.
//

import Foundation

struct Cast: Codable, Identifiable {
    let id, order: Int?
    let name, character, department, profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "original_name"
        case character
        case department = "known_for_department"
        case order
        case profilePath = "profile_path"
    }
}
