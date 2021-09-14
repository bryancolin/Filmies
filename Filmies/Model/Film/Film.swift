//
//  Film.swift
//  Filmies
//
//  Created by bryan colin on 8/4/21.
//

import Foundation

class Film: Codable, Identifiable {
    let id: Int?
    let title, overview: String?
    var description: String {
        if let text = overview, !text.isEmpty {
            return text
        }
        
        return String("No synopsis available yet")
    }
    
    let genres: [Genre]?
    let languages: [Language]?
    let rating: Double?
    var rate: String {
        if let rating = rating {
            return String(rating)
        }
        return String()
    }
    
    let productionCompanies, productionCountries: [Production]?
    
    let backdropPath: String?
    var backdropURL: String {
        if let url = backdropPath {
            return String("https://image.tmdb.org/t/p/w500" + url)
        }
        return posterURL
    }
    
    let posterPath: String?
    var posterURL: String {
        if let url = posterPath {
            return String("https://image.tmdb.org/t/p/w500" + url)
        }
        return String()
    }
    
    let videos: Videos?
    
    let images: Images?
    
    // Extra Variable
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
    
    enum CodingKeys: String, CodingKey {
        case id
        case title = "original_title"
        case overview
        case rating = "vote_average"
        case genres
        case languages = "spoken_languages"
        
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        
        case videos
        case images
        
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
        return posterURL
    }
}
