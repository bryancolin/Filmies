//
//  Production.swift
//  Filmies
//
//  Created by bryan colin on 8/2/21.
//

import Foundation

struct Production: Codable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name
    }
}
