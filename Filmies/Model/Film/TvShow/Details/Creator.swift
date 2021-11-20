//
//  Creator.swift
//  Filmies
//
//  Created by bryan colin on 9/2/21.
//

import Foundation

struct Creator: Codable, Identifiable {
    let id: Int?
    let name, profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case profilePath = "profile_path"
    }
}
