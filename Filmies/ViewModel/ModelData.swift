//
//  ModelData.swift
//  Filmies
//
//  Created by bryan colin on 7/9/21.
//

import Foundation

final class ModelData: ObservableObject {
    
    private let url = "https://api.themoviedb.org/3"
    private let apiKey = "?api_key=\(Bundle.main.infoDictionary?["API_KEY"] as? String ?? "")"
    
    var movieParams = ["movie/day", "movie/week", "movie/now_playing", "movie/popular", "movie/upcoming", "movie/top_rated"]
    var tvShowParams = ["tv/day", "tv/week", "tv/airing_today", "tv/popular", "tv/on_the_air", "tv/top_rated"]
    
    @Published var films = [String: [Film]]()
    @Published var selectedType: FilmType = .movie
    
    @Published var isLoading = false
    @Published var isError = false
    
    init() {
        let _ = (movieParams + tvShowParams).map { fetchFilms(with: $0) }
        
        loadFavoriteFilms(type: K.MovieCategory.favorites, key: K.UserDefaults.movieKey, expecting: [Movie].self)
        loadFavoriteFilms(type: K.TvShowCategory.favorites, key: K.UserDefaults.tvKey, expecting: [TvShow].self)
    }
    
    func fetchFilms(with param: String, name: String = "", pageNumber: Int = 1) {
        isLoading = true
        isError = false
        
        // Trending Params
        let trend = param.contains("/day") || param.contains("/week") ? "trending/" : ""
        
        // Searching Films
        let urlName = name.replacingOccurrences(of: " ", with: "+")
        let query = name.isEmpty ? "" : "&query=\(urlName)"
        
        let fullURL = "\(url)/\(trend)\(param)" + apiKey + query + "&page=\(pageNumber)"
        
        URLSession.shared.request(url: URL(string: fullURL), expecting: Films.self) { [weak self] response in
            switch response {
            case .success(let result):
                DispatchQueue.main.async {
                    guard let data = result.all else { return }
                    
                    if data.isEmpty {
                        self?.isError = true
                    } else {
                        if pageNumber == 1 {
                            self?.films[param] = data
                        } else {
                            self?.films[param]! += data
                        }
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                        self?.isLoading = false
                    }
                }
                
            case .failure(let error):
                self?.isLoading = false
                self?.isError = true
                print(error)
            }
        }
    }
    
    func fetchFilmDetails<T: Codable>(type: FilmType, param: String, id: Int, expecting: T.Type) {
        
        let film = findFilm(param: param, id: id)
        let filmExists = film.exists
        let filmAtIndex = film.index
        
        if filmExists {
            let fullURL = "\(url)/\(type.rawValue)/\(id)" + apiKey + "&append_to_response=videos,casts,credits,images&include_image_language=en"
            
            URLSession.shared.request(url: URL(string: fullURL), expecting: expecting) { [weak self] response in
                switch response {
                case .success(let result):
                    DispatchQueue.main.async {
                        if let film = result as? Film {
                            film.category = param
                            film.details = true
                            self?.films[param]?[filmAtIndex] = film
                        }
                    }
                case .failure(let error):
                    print(error)
                }
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
