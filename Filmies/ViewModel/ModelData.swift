//
//  ModelData.swift
//  Filmies
//
//  Created by bryan colin on 7/9/21.
//

import Foundation
import Alamofire

final class ModelData: ObservableObject {
    
    private let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String
    private let url = "https://api.themoviedb.org/3"
    var params = ["day", "week", "now_playing", "popular", "upcoming", "top_rated"]
    
    @Published var movies = [String: [Movie]]()
    @Published var sampleMovies = [
        Movie(id: 1, title: "Black Widow", description: "Avengers", runTime: 134, releaseDate: "2021", url: "/qAZ0pzat24kLdO3o8ejmbLxyOac.jpg"),
        Movie(id: 2, title: "Black Widow", description: "Avengers", runTime: 134, releaseDate: "2021", url: "/qAZ0pzat24kLdO3o8ejmbLxyOac.jpg")
    ]
    
    func fetchMovies() {
        for (index, param) in params.enumerated() {
            let trend = (index == 0 || index == 1) ? "trending/" : ""
            
            AF.request("\(url)/\(trend)movie/\(param)?api_key=\(apiKey ?? "")")
                .validate()
                .responseDecodable(of: Movies.self) { response in
                    guard let result = response.value else { return }
                    DispatchQueue.main.async { [self] in
                        movies[param] = result.all
                    }
                }
        }
    }
    
    func fetchMovieDetails(param: String, id: Int) {
        guard let safeMovies = movies[param] else { return }
        
        for (index, movie) in safeMovies.enumerated() {
            if movie.id == id && movie.details == false {
                AF.request("\(url)/movie/\(movie.id)?api_key=\(apiKey ?? "")")
                    .validate()
                    .responseDecodable(of: Movie.self) { response in
                        guard let result = response.value else { return }
                        
                        self.movies[param]?[index] = result
                        self.movies[param]?[index].details = true
                        
                    }
            }
        }
    }
}
