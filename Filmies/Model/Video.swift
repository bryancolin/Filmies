//
//  Video.swift
//  Filmies
//
//  Created by bryan colin on 7/20/21.
//

import Foundation

struct Video: Codable {
    var key: String
    var site: String
    var type: String
    var youtubeURL: String {
        return "https://www.youtube.com/embed/" + key
    }
    
    enum CodingKeys: String, CodingKey {
        case key
        case site
        case type
    }
}
