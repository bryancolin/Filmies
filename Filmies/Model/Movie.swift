//
//  Movie.swift
//  Filmies
//
//  Created by bryan colin on 7/9/21.
//

import Foundation

class Movie: Film {
    var category: String = ""
    var details: Bool? = nil
    var isFavorite: Bool? = nil
    
    var addedAt: Double? = nil
    var addedDate: Date {
        if let dateInDouble = addedAt {
            return dateInDouble.toDate()
        }
        return Date()
    }
    
    var runTime: Int?
    var duration: String? {
        if let time = runTime {
            return time.convert()
        }
        return String()
    }
    
    let releaseDate: String?
    var releaseYear: String {
        if let date = releaseDate {
            return String(date.prefix(4))
        }
        return String("-")
    }
    
    enum CodingKeys: String, CodingKey {
        case runTime = "runtime"
        case releaseDate = "release_date"
        
        case details
        case isFavorite
        case addedAt
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.runTime = try container.decodeIfPresent(Int.self, forKey: .runTime)
        self.releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate)
        try super.init(from: decoder)
    }
    
    func getPosters(at index: Int) -> String {
        if let images = images?.posters {
            if index < images.count {
                return images[index].url
            }
        }
        return posterUrl
    }
}




