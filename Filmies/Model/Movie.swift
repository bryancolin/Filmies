//
//  Movie.swift
//  Filmies
//
//  Created by bryan colin on 7/9/21.
//

import Foundation
import UIKit

struct Movie: Codable, Hashable, Identifiable {
    var id: Int
    var title: String
    var description: String
    
    var runTime: Int?
    var duration: String {
        if let time = runTime {
            let hours = time / 60
            let minutes = time % 60
            return String("\(hours)h \(minutes)m")
        }
        return String()
    }
    
    var releaseDate: String
    var releaseYear: String {
        return String(releaseDate.prefix(4))
    }
    
    var url: String 
    var imageURL: String {
        return "https://image.tmdb.org/t/p/w500" + url
    }
    
    var offset: CGFloat = 0
    
    enum CodingKeys: String, CodingKey {
        case id
        case title = "original_title"
        case description = "overview"
        case releaseDate = "release_date"
        case url = "poster_path"
        case runTime = "runtime"
    }
}
