//
//  ModelData.swift
//  Filmies
//
//  Created by bryan colin on 7/9/21.
//

import SwiftUI

protocol FileDocument {
    
    static var documentsFolder: URL { get }
    
    func loadFavoriteFilms<T: Codable>(type: String, key: String, expecting: T.Type)
    func saveFavoriteFilms(type: String, key: String)
}

final class ModelData: ObservableObject {
    
    private let service = APIService()
    
    var movieParams = [K.Movie.daily, K.Movie.weekly, K.Movie.nowPlaying, K.Movie.topRated, K.Movie.popular, K.Movie.upcoming]
    var tvShowParams = [K.Tv.daily, K.Tv.weekly, K.Tv.airingToday, K.Tv.topRated, K.Tv.popular, K.Tv.onAir]
    
    @AppStorage(K.Settings.selectedFilmType) var selectedType: FilmType = .movie
    
    @Published var films = [String: [Film]]()
    @Published var selectedFilmId: Int = 0
    @Published var selectedCategory: String = ""
    
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
        
        guard let data = await service.getFilms(with: param, name: name, pageNumber: pageNumber) else {
            isError = true
            isLoading = false
            return
        }
        
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
    }
    
    @MainActor
    func fetchFilmDetails<T: Codable>(type: FilmType, expecting: T.Type) async {
        let film = findFilm(param: selectedCategory, id: selectedFilmId)
        let filmExists = film.exists
        let filmAtIndex = film.index
        
        if filmExists {
            guard let data = await service.getFilmDetails(filmId: selectedFilmId, type: type.rawValue, expecting: expecting) else { return }
            data.category = selectedCategory
            data.details = true
            films[selectedCategory]?[filmAtIndex] = data
        }
    }
    
    func highlightFilm(type: String, check: Bool) {
        
        let film = findFilm(param: selectedCategory, id: selectedFilmId)
        //        let movieExists = movie.0
        let filmAtIndex = film.index
        
        // Check Favorites to TRUE/FALSE from its category
        //        if movieExists {
        //            films[param]?[movieAtIndex].isFavorite = check
        //        }
        
        if check {
            // Append Favorite Movie
            guard let film = films[selectedCategory]?[filmAtIndex] else { return }
            film.isFavorite = true
            film.addedAt = Date().timeIntervalSince1970
            
            if films[type] == nil {
                films[type] = [film]
            } else {
                films[type]?.insert(film, at: 0)
            }
        } else {
            // Remove Favorite Movie
            let favoriteFilm = findFilm(param: type, id: selectedFilmId)
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
    func fetchEpisodes(seasonId: Int) async -> [Episode]? {
        return await service.getEpisodes(filmId: selectedFilmId, seasonId: seasonId)
    }
    
    @MainActor
    func fetchPeople(id: Int) async {
        if people[id] == nil {
            let data = await service.getPeople(id: id)
            people[data?.id ?? 0] = data
            films[String(id) + K.People.movie] = data?.movieCredits?.all
            films[String(id) + K.People.tv] = data?.tvCredits?.all
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
