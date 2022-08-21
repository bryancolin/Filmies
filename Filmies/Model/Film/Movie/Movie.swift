//
//  Movie.swift
//  Filmies
//
//  Created by bryan colin on 7/9/21.
//

import Foundation

class Movie: Film {
    let runTime: Int?
    let releaseDate: String?
    
    let casts: Casts?
    
    enum CodingKeys: String, CodingKey {
        case runTime = "runtime"
        case releaseDate = "release_date"
        
        case casts
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.runTime = try container.decodeIfPresent(Int.self, forKey: .runTime)
        self.releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate)
        self.casts = try container.decodeIfPresent(Casts.self, forKey: .casts)
        
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(runTime, forKey: .runTime)
        try container.encode(releaseDate, forKey: .releaseDate)
        try container.encode(casts, forKey: .casts)
        
        try super.encode(to: encoder)
    }
}

extension Movie {
    var duration: String {
        return runTime?.toTimeString() ?? "-"
    }
    
    var releaseYear: String {
        return String(releaseDate?.prefix(4) ?? "-")
    }
}




