//
//  Movie.swift
//  Filmies
//
//  Created by bryan colin on 7/9/21.
//

import Foundation

struct Movie: Codable, Identifiable {
    let id: Int?
    let title: String?
    let description: String?
    let genres: [Genre]?
    let languages: [Language]?
    
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
    
    let url: String?
    var imageURL: String {
        if let url = url {
            return String("https://image.tmdb.org/t/p/w500" + url)
        }
        return String()
    }
    
    let videos: Videos?
    
    let casts: Casts?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title = "original_title"
        case description = "overview"
        case genres
        case languages = "spoken_languages"
        case runTime = "runtime"
        case releaseDate = "release_date"
        
        case url = "poster_path"
        
        case videos
        case casts
        
        case details
        case isFavorite
        case addedAt
    }
}
