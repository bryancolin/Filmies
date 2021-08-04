//
//  Film.swift
//  Filmies
//
//  Created by bryan colin on 8/4/21.
//

import Foundation

class Film: Codable, Identifiable {
    let id: Int?
    let title, description: String?
    let genres: [Genre]?
    let languages: [Language]?
    let rating: Double?
    var rate: String {
        if let rating = rating {
            return String(rating)
        }
        return String()
    }
    
    let productionCompanies: [Production]?
    let productionCountries: [Production]?
    
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
    
    enum CodingKeys: String, CodingKey {
        case id
        case title = "original_title"
        case description = "overview"
        case rating = "vote_average"
        case genres
        case languages = "spoken_languages"
        
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        
        case videos
        case casts
        case images
        
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
    }
}
