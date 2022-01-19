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
        if let text = overview, !text.isEmpty { return text }
        return String("No synopsis available yet")
    }
    
    var rate: String {
        return rating?.toString() ?? ""
    }
    
    var addedDate: Date {
        return addedAt?.toDate() ?? Date()
    }
    
    static func getPlaceholderData() -> [Film] {
        let data: Data
        
        guard let file = Bundle.main.url(forResource: "sampleData.json", withExtension: nil) else { fatalError("Couldn't find file in main bundle.") }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load file from main bundle")
        }
        
        do {
            let result = try JSONDecoder().decode(Films.self, from: data)
            if let films  = result.all {
                return films
            }
        } catch {
            fatalError("Couldn't parse file.")
        }
        
        return [Film]()
    }
}
