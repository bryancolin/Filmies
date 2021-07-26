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
                .responseDecodable(of: Movies.self) { [self] response in
                    guard let result = response.value else { return }
                    
                    movies[param] = result.all
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4) { [self] in
                        isLoading = false
                    }
                }
        }
    }
    
    func fetchMovieDetails(param: String, id: Int) {
        guard let safeMovies = movies[param] else { return }
        
        for (index, movie) in safeMovies.enumerated() {
            if movie.id == id {
                guard let movieId = movie.id else { return }
                
                AF.request("\(url)/movie/\(movieId)\(apiKey)&append_to_response=videos,casts")
                    .validate()
                    .responseDecodable(of: Movie.self) { response in
                        guard let result = response.value else { return }
                        
                        DispatchQueue.main.async { [self] in
                            movies[param]?[index] = result
                            movies[param]?[index].details = true
                        }
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
            .responseDecodable(of: Movies.self) { [self] response in
                
                switch response.result {
                case .success:
                    guard let result = response.value else { return}
                    
                    movies["search"] = result.all
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                        isLoading = false
                    }
                    
                case .failure(_):
                    isLoading = false
                    isError = true
                }
            }
    }
}
