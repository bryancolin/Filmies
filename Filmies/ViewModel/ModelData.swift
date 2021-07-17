//
//  ModelData.swift
//  Filmies
//
//  Created by bryan colin on 7/9/21.
//

import Foundation
import Alamofire
import SwiftyJSON

final class ModelData: ObservableObject {
    
    private let url = "https://api.themoviedb.org/3"
    private let apiKey = "?api_key=\(Bundle.main.infoDictionary?["API_KEY"] as? String ?? "")"
    var params = ["day", "week", "now_playing", "popular", "upcoming", "top_rated"]
    
    @Published var movies = [String: [Movie]]()
    
    func fetchMovies() {
        for (index, param) in params.enumerated() {
            let trend = (index == 0 || index == 1) ? "trending/" : ""
            
            AF.request("\(url)/\(trend)movie/\(param)\(apiKey)")
                .validate()
                .responseDecodable(of: Movies.self) { response in
                    guard let result = response.value else { return }
                    print(result.all)
                    DispatchQueue.main.async { [self] in
                        movies[param] = result.all
                    }
                }
        }
    }
    
    func fetchMovieDetails(param: String, id: Int) {
        guard let safeMovies = movies[param] else { return }
        
        for (index, movie) in safeMovies.enumerated() {
            if movie.id == id {
                AF.request("\(url)/movie/\(movie.id)\(apiKey)")
                    .validate()
                    .responseDecodable(of: Movie.self) { response in
                        guard let result = response.value else { return }
                        
                        DispatchQueue.main.async { [self] in
                            fetchMovieTrailer(movieId: movie.id) { key in
                                movies[param]?[index].key = key
                            }
                            movies[param]?[index] = result
                            movies[param]?[index].details = true
                        }
                    }
            }
        }
    }
    
    func fetchMovieTrailer(movieId: Int, completion: @escaping (String) -> Void) {
        AF.request("\(url)/movie/\(movieId)/videos\(apiKey)")
            .validate()
            .responseJSON { response in
                guard let result = response.value else { return }
                let json = JSON(result)
                completion(json["results"][0]["key"].string ?? "")
            }
    }
}
