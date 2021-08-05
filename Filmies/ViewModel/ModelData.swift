//
//  ModelData.swift
//  Filmies
//
//  Created by bryan colin on 7/9/21.
//

import Foundation
import Alamofire

final class ModelData: ObservableObject {
    
    private let url = "https://api.themoviedb.org/3"
    private let apiKey = "?api_key=\(Bundle.main.infoDictionary?["API_KEY"] as? String ?? "")"
    
    var movieParams = ["movie/day", "movie/week", "movie/now_playing", "movie/popular", "movie/upcoming", "movie/top_rated"]
    var tvShowParams = ["tv/day", "tv/week", "tv/airing_today", "tv/popular", "tv/on_the_air", "tv/top_rated"]
    
    @Published var films = [String: [Film]]()
    @Published var selectedType: FilmType = .movie
    
    @Published var isLoading = false
    @Published var isError = false
    
    func fetchFilms() {
        isLoading = true
        
        for param in movieParams + tvShowParams {
            let trend = param.contains("/day") || param.contains("/week") ? "trending/" : ""
            
            AF.request("\(url)/\(trend)\(param)\(apiKey)")
                .validate(statusCode: 200..<600)
                .responseDecodable(of: Films.self) { [self] response in
                    guard let result = response.value else { return }
                    
                    DispatchQueue.main.async {
                        films[param] = result.all
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4) { [self] in
                            isLoading = false
                        }
                    }
                }
        }
    }
    
    func fetchFilmDetails<T: Codable>(type: FilmType, param: String, id: Int, expecting: T.Type) {
        
        let film = findFilm(param: param, id: id)
        let filmExists = film.0
        let filmAtIndex = film.1
        
        if filmExists {
            AF.request("\(url)/\(type.rawValue)/\(id)\(apiKey)&append_to_response=videos,casts,credits,images&include_image_language=en")
                .validate()
                .responseDecodable(of: expecting) { response in
                    guard let result = response.value as? Film else { return }
                    
                    DispatchQueue.main.async { [self] in
                        result.category = param
                        result.details = true
                        films[param]?[filmAtIndex] = result
                    }
                }
        }
    }
    
    func searchFilm(type: String, name: String) {
        isLoading = true
        isError = false
        
        let urlName = name.replacingOccurrences(of: " ", with: "+")
        
        AF.request("\(url)/search/\(type)\(apiKey)&query=\(urlName)")
            .validate()
            .responseDecodable(of: Films.self) { [self] response in
                
                switch response.result {
                case .success:
                    guard let result = response.value else { return}
                    
                    films["search"] = result.all
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                        isLoading = false
                    }
                    
                case .failure(_):
                    isLoading = false
                    isError = true
                }
            }
    }
    
    func highlightMovie(param: String, id: Int, check: Bool) {
        
        let movie = findFilm(param: param, id: id)
        //        let movieExists = movie.0
        let movieAtIndex = movie.1
        
        // Check Favorites to TRUE/FALSE from its category
        //        if movieExists {
        //            films[param]?[movieAtIndex].isFavorite = check
        //        }
        
        if check {
            // Append Favorite Movie
            guard let movie = films[param]?[movieAtIndex] as? Movie else { return }
            movie.isFavorite = true
            movie.addedAt = Date().timeIntervalSince1970
            
            if films[K.MovieCategory.favorites] == nil {
                films[K.MovieCategory.favorites] = [movie]
            } else {
                films[K.MovieCategory.favorites]?.insert(movie, at: 0)
            }
        } else {
            // Remove Favorite Movie
            let favoriteMovie = findFilm(param: K.MovieCategory.favorites, id: id)
            if favoriteMovie.0 {
                films[K.MovieCategory.favorites]?.remove(at: favoriteMovie.1)
            }
        }
        
        saveFavoriteMovies()
    }
    
    func findFilm(param: String, id: Int) -> (Bool, Int) {
        if let safeMovies = films[param] {
            for (index, movie) in safeMovies.enumerated() {
                if movie.id == id  {
                    return (true, index)
                }
            }
        }
        return (false, 0)
    }
    
    // Load from User Defaults
    func loadFavoriteMovies() {
        if let data = UserDefaults.standard.data(forKey: K.userDefaultsMovieKey) {
            if let decoded = try? JSONDecoder().decode([Movie].self, from: data) {
                DispatchQueue.main.async { [self] in
                    films[K.MovieCategory.favorites] = decoded.sorted(by: { $0.addedAt ?? 0 > $1.addedAt ?? 0 })
                }
            }
        }
    }
    
    // Store in User Defaults
    func saveFavoriteMovies() {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        if let encoded = try? encoder.encode(films[K.MovieCategory.favorites]) {
            print(String(data: encoded, encoding: .utf8)!)
            UserDefaults.standard.set(encoded, forKey: K.userDefaultsMovieKey)
        }
    }
}
