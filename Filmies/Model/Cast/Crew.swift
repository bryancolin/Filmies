//
//  Crew.swift
//  Filmies
//
//  Created by bryan colin on 7/23/21.
//

import Foundation

struct Crew: Codable, Identifiable {
    let id: Int?
    let name, department, job, profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "original_name"
        case department = "known_for_department"
        case job
        case profilePath = "profile_path"
    }
}
