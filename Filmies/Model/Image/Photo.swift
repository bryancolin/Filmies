//
//  Photo.swift
//  Filmies
//
//  Created by bryan colin on 8/1/21.
//

import Foundation

struct Photo: Codable {
    let filePath: String?
    
    enum CodingKeys: String, CodingKey {
        case filePath = "file_path"
    }
}
