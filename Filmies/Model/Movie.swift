//
//  Movie.swift
//  Filmies
//
//  Created by bryan colin on 7/9/21.
//

import Foundation

struct Movie: Codable, Identifiable {
    var id: Int
    var title: String
    var description: String
    
    var details: Bool = false
    
    var runTime: Int?
    var duration: String? {
        if let time = runTime {
            let hours = time / 60
            let minutes = time % 60
            return String(hours > 0 ? "\(hours)h " : "") + "\(minutes)m"
        }
        return String()
    }
    
    var releaseDate: String?
    var releaseYear: String {
        if let date = releaseDate {
            return String(date.prefix(4))
        }
        return String("-")
    }
    
    var url: String 
    var imageURL: String {
        return "https://image.tmdb.org/t/p/w500" + url
    }
    
    let videos: Videos?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title = "original_title"
        case description = "overview"
        case releaseDate = "release_date"
        case url = "poster_path"
        case runTime = "runtime"
        case videos
    }
}
