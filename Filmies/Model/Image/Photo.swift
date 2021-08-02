//
//  Photo.swift
//  Filmies
//
//  Created by bryan colin on 8/1/21.
//

import Foundation

struct Photo: Codable {
    let filePath: String?
    var url: String {
        if let url = filePath {
            return String("https://image.tmdb.org/t/p/w500" + url)
        }
        return String()
    }
    
    enum CodingKeys: String, CodingKey {
        case filePath = "file_path"
    }
}
