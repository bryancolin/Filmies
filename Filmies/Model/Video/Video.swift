//
//  Video.swift
//  Filmies
//
//  Created by bryan colin on 7/20/21.
//

import Foundation

struct Video: Codable {
    let name: String?
    let key: String?
    let site: String?
    let type: String?
    
    var youtubeURL: String {
        if let key = key {
            return "https://www.youtube.com/embed/" + key
        }
        return String()
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case key
        case site
        case type
    }
}
