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
    
    var movieParams = [K.Movie.daily, K.Movie.weekly, K.Movie.nowPlaying, K.Movie.topRated, K.Movie.popular, K.Movie.popular]
    var tvShowParams = [K.Tv.daily, K.Tv.weekly, K.Tv.airingToday, K.Tv.topRated, K.Tv.popular, K.Tv.onAir]
    
    @Published var films = [String: [Film]]()
    @Published var selectedType: FilmType = .movie
    
    @Published var people = [Int: People]()
    
    @Published var isLoading = false
    @Published var isError = false
    
    init() {
        let _ = (movieParams + tvShowParams).map { fetchFilms(with: $0) }
        
        loadFavoriteFilms(type: K.Movie.favorites, key: K.UserDefaults.movieKey, expecting: [Movie].self)
        loadFavoriteFilms(type: K.Tv.favorites, key: K.UserDefaults.tvKey, expecting: [TvShow].self)
    }
    
    func fetchFilms(with param: String, name: String = "", pageNumber: Int = 1) {
        isLoading = true
        isError = false
        
        // Searching Films (Encoding Query)
        let urlName = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let query = name.isEmpty ? "" : "&query=\(urlName ?? "")"
        
        let fullURL = "\(url)/\(param)" + apiKey + query + "&page=\(pageNumber)"
        
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
        
        saveFavoriteFilms(type: type, key: type == K.Movie.favorites ? K.UserDefaults.movieKey : K.UserDefaults.tvKey)
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
    
    func fetchPeople(id: Int) {
        let fullURL = "\(url)/person/\(id)" + apiKey + "&append_to_response=movie_credits,tv_credits&include_image_language=en"
        
        URLSession.shared.request(url: URL(string: fullURL), expecting: People.self) { [weak self] response in
            switch response {
            case .success(let result):
                DispatchQueue.main.async {
                    self?.people[result.id ?? 0] = result
                    
                    self?.films[String(id) + K.People.movie] = result.movieCredits?.all
                    self?.films[String(id) + K.People.tv] = result.tvCredits?.all
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
