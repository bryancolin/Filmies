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
        let filmExists = film.exists
        let filmAtIndex = film.index
        
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
                    guard let result = response.value else { return }
                    
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
    
    func highlightFilm(type: String, param: String, id: Int, check: Bool) {
        
        let film = findFilm(param: param, id: id)
        //        let movieExists = movie.0
        let filmAtIndex = film.index
        
        // Check Favorites to TRUE/FALSE from its category
        //        if movieExists {
        //            films[param]?[movieAtIndex].isFavorite = check
        //        }
        
        if check {
            // Append Favorite Movie
            guard let film = films[param]?[filmAtIndex] else { return }
            film.isFavorite = true
            film.addedAt = Date().timeIntervalSince1970
            
            if films[type] == nil {
                films[type] = [film]
            } else {
                films[type]?.insert(film, at: 0)
            }
        } else {
            // Remove Favorite Movie
            let favoriteFilm = findFilm(param: type, id: id)
            if favoriteFilm.exists {
                films[type]?.remove(at: favoriteFilm.index)
            }
        }
        
        saveFavoriteFilms(type: type, key: type == K.MovieCategory.favorites ? K.UserDefaults.movieKey : K.UserDefaults.tvKey)
    }
    
    func findFilm(param: String, id: Int) -> (exists: Bool, index: Int) {
        if let safeFilms = films[param] {
            for (index, film) in safeFilms.enumerated() {
                if film.id == id  {
                    return (exists: true, index: index)
                }
            }
        }
        return (exists: false, index: 0)
    }
    
    // Load from User Defaults
    func loadFavoriteFilms<T: Codable>(type: String, key: String, expecting: T.Type) {
        if let data = UserDefaults.standard.data(forKey: key) {
            if let decoded = try? JSONDecoder().decode(expecting, from: data) {
                DispatchQueue.main.async { [self] in
                    if let datas = decoded as? [Film] {
                        films[type] = datas.sorted(by: { $0.addedAt ?? 0 > $1.addedAt ?? 0 })
                    }
                }
            }
        }
    }
    
    // Store in User Defaults
    func saveFavoriteFilms(type: String, key: String) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        if let encoded = try? encoder.encode(films[type]) {
            print(String(data: encoded, encoding: .utf8)!)
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
}
