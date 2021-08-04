//
//  Movie.swift
//  Filmies
//
//  Created by bryan colin on 7/9/21.
//

import Foundation

struct Movie: Codable, Identifiable {
    let id: Int?
    let title, description: String?
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
    
    let rating: Double?
    var rate: String {
        if let rating = rating {
            return String(rating)
        }
        return String()
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
    
    let backdropPath: String?
    var backdropUrl: String {
        if let url = backdropPath {
            return String("https://image.tmdb.org/t/p/w500" + url)
        }
        return posterUrl
    }
    
    let posterPath: String?
    var posterUrl: String {
        if let url = posterPath {
            return String("https://image.tmdb.org/t/p/w500" + url)
        }
        return String()
    }
    
    let videos: Videos?
    
    let casts: Casts?
    
    let images: Images?
    
    let productionCompanies: [Production]?
    let productionCountries: [Production]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title = "original_title"
        case description = "overview"
        case rating = "vote_average"
        case genres
        case languages = "spoken_languages"
        case runTime = "runtime"
        case releaseDate = "release_date"
        
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        
        case videos
        case casts
        case images
        
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        
        case details
        case isFavorite
        case addedAt
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
