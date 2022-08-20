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
    
    let genres: [Genre]?
    let languages: [Language]?
    let rating: Double?
    
    let productionCompanies, productionCountries: [Production]?
    
    let backdropPath, posterPath: String?
    
    let videos: Videos?

    let images: Images?
    
    // Extra Variable
    var category: String = ""
    var details: Bool? = nil
    var isFavorite: Bool? = nil
    
    var addedAt: Double? = nil
    
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
}

extension Film {
    var description: String {
        guard let text = overview, !text.isEmpty else { return String("") }
        return text
    }
    
    var rate: String {
        return rating?.toString() ?? ""
    }
    
    var addedDate: Date {
        return addedAt?.toDate() ?? Date()
    }
    
    static func getPlaceholderData() -> [Film] {
        let films = Bundle.main.decode(Films.self, from: "sampleData.json")
        return films.all ?? []
    }
}
