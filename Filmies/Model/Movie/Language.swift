//
//  Language.swift
//  Filmies
//
//  Created by bryan colin on 7/24/21.
//

import Foundation

struct Language: Codable, Identifiable {
    let id: String?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "iso_639_1"
        case name
    }
}
