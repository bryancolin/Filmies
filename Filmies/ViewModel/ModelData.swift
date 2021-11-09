//
//  ModelData.swift
//  Filmies
//
//  Created by bryan colin on 7/9/21.
//

import Foundation
import SwiftUI

protocol FileDocument {
    
    static var documentsFolder: URL { get }
    
    func loadFavoriteFilms<T: Codable>(type: String, key: String, expecting: T.Type)
    func saveFavoriteFilms(type: String, key: String)
}

final class ModelData: ObservableObject {
    
    // URL
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
        Task {
            for param in (movieParams + tvShowParams) { await fetchFilms(with: param) }
        }
        
        loadFavoriteFilms(type: K.Movie.favorites, key: K.FileDocument.movieKey, expecting: [Movie].self)
        loadFavoriteFilms(type: K.Tv.favorites, key: K.FileDocument.tvKey, expecting: [TvShow].self)
    }
    
    @MainActor
    func fetchFilms(with param: String, name: String = "", pageNumber: Int = 1) async {
        isLoading = true
        isError = false
        
        // Searching Films (Encoding Query)
        let urlName = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let query = name.isEmpty ? "" : "&query=\(urlName ?? "")"
        
        let fullURL = "\(url)/\(param)" + apiKey + query + "&page=\(pageNumber)"
        
        do {
            let result = try await URLSession.shared.request(url: URL(string: fullURL), expecting: Films.self)
            guard let data = result.all else { return }
            
            if data.isEmpty {
                isError = true
            } else {
                if pageNumber == 1 {
                    films[param] = data
                } else {
                    films[param]?.append(contentsOf: data)
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                self.isLoading = false
            }
        } catch {
            isLoading = false
            isError = true
            print(error)
        }
    }
    
    @MainActor
    func fetchFilmDetails<T: Codable>(type: FilmType, param: String, id: Int, expecting: T.Type) async {
        
        let film = findFilm(param: param, id: id)
        let filmExists = film.exists
        let filmAtIndex = film.index
        
        if filmExists {
            let fullURL = "\(url)/\(type.rawValue)/\(id)" + apiKey + "&append_to_response=videos,casts,credits,images&include_image_language=en"
            
            do {
                let result = try await URLSession.shared.request(url: URL(string: fullURL), expecting: expecting)
                if let film = result as? Film {
                    film.category = param
                    film.details = true
                    films[param]?[filmAtIndex] = film
                }
            } catch {
                print(error)
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
        
        saveFavoriteFilms(type: type, key: type == K.Movie.favorites ? K.FileDocument.movieKey : K.FileDocument.tvKey)
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
    
    @MainActor
    func fetchPeople(id: Int) async {
        let fullURL = "\(url)/person/\(id)" + apiKey + "&append_to_response=movie_credits,tv_credits&include_image_language=en"
        
        if people[id] == nil {
            do {
                let result = try await URLSession.shared.request(url: URL(string: fullURL), expecting: People.self)
                people[result.id ?? 0] = result
                films[String(id) + K.People.movie] = result.movieCredits?.all
                films[String(id) + K.People.tv] = result.tvCredits?.all
            } catch {
                print(error)
            }
        }
    }
}

//MARK: - Document Folder

extension ModelData: FileDocument {
    
    // Document
    static var documentsFolder: URL {
        do {
            return try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        } catch {
            fatalError("Can't find documents directory.")
        }
    }
    
    // Load from Documents Folder
    func loadFavoriteFilms<T: Codable>(type: String, key: String, expecting: T.Type) {
        let fileURL: URL = ModelData.documentsFolder.appendingPathComponent("\(key).data")
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let data = try? Data(contentsOf: fileURL) else { return }
            guard let decoded = try? JSONDecoder().decode(expecting, from: data) else { fatalError("Can't decode saved data.") }
            
            DispatchQueue.main.async {
                if let datas = decoded as? [Film] {
                    self?.films[type] = datas.sorted(by: { $0.addedAt ?? 0 > $1.addedAt ?? 0})
                }
            }
        }
    }
    
    // Store in Documents Folder
    func saveFavoriteFilms(type: String, key: String) {
        let fileURL: URL = ModelData.documentsFolder.appendingPathComponent("\(key).data")
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let encoded = try? encoder.encode(self?.films[type]) else { fatalError("Can't write to file.") }
            print(String(data: encoded, encoding: .utf8)!)
            
            do {
                let outfile = fileURL
                try encoded.write(to: outfile)
            } catch {
                fatalError("Can't write to file")
            }
        }
    }
}
