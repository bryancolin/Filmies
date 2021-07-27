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
    var details: Bool = false
    var isFavorite: Bool = false
    var addedAt: Double = Date().timeIntervalSince1970
    
    var runTime: Int?
    var duration: String? {
        if let time = runTime {
            let hours = time / 60
            let minutes = time % 60
            return String(hours > 0 ? "\(hours)h " : "") + "\(minutes)m"
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
    }
}
