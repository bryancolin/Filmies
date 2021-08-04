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
    var params = ["day", "week", "now_playing", "popular", "upcoming", "top_rated"]
    
    @Published var movies = [String: [Movie]]()
    
    @Published var isLoading = false
    @Published var isError = false
    
    func fetchMovies() {
        isLoading = true
        
        for (index, param) in params.enumerated() {
            let trend = (index == 0 || index == 1) ? "trending/" : ""
            
            AF.request("\(url)/\(trend)movie/\(param)\(apiKey)")
                .validate()
                .responseDecodable(of: Films.self) { [self] response in
                    guard let result = response.value else { return }
                    
                    DispatchQueue.main.async {
                        movies[param] = result.all as? [Movie]
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4) { [self] in
                            isLoading = false
                        }
                    }
                }
        }
    }
    
    func fetchMovieDetails(param: String, id: Int) {
        
        let movie = findMovie(param: param, id: id)
        let movieExists = movie.0
        let movieAtIndex = movie.1
        
        if movieExists {
            AF.request("\(url)/movie/\(id)\(apiKey)&append_to_response=videos,casts,images&include_image_language=en")
                .validate()
                .responseDecodable(of: Movie.self) { response in
                    guard let result = response.value else { return }
                    
                    DispatchQueue.main.async { [self] in
                        movies[param]?[movieAtIndex] = result
                        movies[param]?[movieAtIndex].category = param
                        movies[param]?[movieAtIndex].details = true
                    }
                }
        }
    }
    
    func searchMovie(name: String) {
        isLoading = true
        isError = false
        
        let urlName = name.replacingOccurrences(of: " ", with: "+")
        
        AF.request("\(url)/search/movie\(apiKey)&query=\(urlName)")
            .validate()
            .responseDecodable(of: Films.self) { [self] response in
                
                switch response.result {
                case .success:
                    guard let result = response.value else { return}
                    
                    movies["search"] = result.all as? [Movie]
                    
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
        
        let movie = findMovie(param: param, id: id)
        let movieExists = movie.0
        let movieAtIndex = movie.1
        
        // Check Favorites to TRUE/FALSE from its category
        if movieExists {
            movies[param]?[movieAtIndex].isFavorite = check
        }
        
        if check {
            // Append Favorite Movie
            guard var movie = movies[param]?[movieAtIndex] else { return }
            movie.isFavorite = true
            movie.addedAt = Date().timeIntervalSince1970
            
            if movies[K.MovieCategory.favorites] == nil {
                movies[K.MovieCategory.favorites] = [movie]
            } else {
                movies[K.MovieCategory.favorites]?.insert(movie, at: 0)
            }
        } else {
            // Remove Favorite Movie
            let favoriteMovie = findMovie(param: K.MovieCategory.favorites, id: id)
            if favoriteMovie.0 {
                movies[K.MovieCategory.favorites]?.remove(at: favoriteMovie.1)
            }
        }
        
        saveFavoriteMovies()
    }
    
    func findMovie(param: String, id: Int) -> (Bool, Int) {
        if let safeMovies = movies[param] {
            for (index, movie) in safeMovies.enumerated() {
                if movie.id == id  {
                    return (true, index)
                }
            }
        }
        return (false, 0)
    }
    
    func loadFavoriteMovies() {
        if let data = UserDefaults.standard.data(forKey: K.userDefaultsKey) {
            if let decoded = try? JSONDecoder().decode([Movie].self, from: data) {
                DispatchQueue.main.async { [self] in
                    movies[K.MovieCategory.favorites] = decoded.sorted(by: { $0.addedAt ?? 0 > $1.addedAt ?? 0 })
                }
            }
        }
    }
    
    func saveFavoriteMovies() {
        // Store in User Defaults
        if let encoded = try? JSONEncoder().encode(movies[K.MovieCategory.favorites]) {
            UserDefaults.standard.set(encoded, forKey: K.userDefaultsKey)
        }
    }
}
