//
//  TvShow.swift
//  Filmies
//
//  Created by bryan colin on 8/4/21.
//

import Foundation

class TvShow: Film {
    var details: Bool? = nil
    
    let originalName: String?
    
    var runTime: Int?
    var duration: String? {
        if let time = runTime {
            return time.convert()
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
    
    enum CodingKeys: String, CodingKey {
        case originalName = "original_name"
        case runTime = "episode_run_time"
        case firstAirDate = "first_air_date"
        
        case details
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.runTime = try container.decodeIfPresent(Int.self, forKey: .runTime)
        self.firstAirDate = try container.decodeIfPresent(String.self, forKey: .firstAirDate)
        self.originalName = try container.decodeIfPresent(String.self, forKey: .originalName)
        
        try super.init(from: decoder)
    }
}
