//
//  Crew.swift
//  Filmies
//
//  Created by bryan colin on 7/23/21.
//

import Foundation

struct Crew: Codable, Identifiable {
    let id: Int?
    let name, department, job: String?
    
    let profilePicture: String?
    var imageURL: String {
        if let url = profilePicture {
            return String("https://image.tmdb.org/t/p/w500" + url)
        }
        return String()
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "original_name"
        case department = "known_for_department"
        case job
        case profilePicture = "profile_path"
    }
}
