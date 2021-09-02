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
    var imageURL: String {
        if let url = profilePath {
            return String("https://image.tmdb.org/t/p/w500" + url)
        }
        return String()
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case profilePath = "profile_path"
    }
}
