//
//  TvShow.swift
//  Filmies
//
//  Created by bryan colin on 8/4/21.
//

import Foundation

class TvShow: Film {
    let name: String?
    
    var runTime: [Int]?
    var duration: String? {
        if let time = runTime {
            return time.first?.convert() ?? String()
        }
        return String()
    }
    
    let firstAirDate: String?
    var releaseYear: String {
        if let date = firstAirDate {
            return String(date.prefix(4))
        }
        return String("-")
    }
    
    let casts: Casts?
    
    enum CodingKeys: String, CodingKey {
        case name
        case runTime = "episode_run_time"
        case firstAirDate = "first_air_date"
        
        case casts = "credits"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.runTime = try container.decodeIfPresent([Int].self, forKey: .runTime)
        self.firstAirDate = try container.decodeIfPresent(String.self, forKey: .firstAirDate)
        self.casts = try container.decodeIfPresent(Casts.self, forKey: .casts)
        
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(name, forKey: .name)
        try container.encode(runTime, forKey: .runTime)
        try container.encode(firstAirDate, forKey: .firstAirDate)
        try container.encode(casts, forKey: .casts)
        
        try super.encode(to: encoder)
    }
}
