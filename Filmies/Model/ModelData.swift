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
    let params = ["now_playing", "popular", "top_rated", "upcoming"]
    
    @Published var sampleMovies = [
        Movie(id: 1, title: "Black Widow", description: "Avengers", runTime: 134, releaseDate: "2021", url: "/qAZ0pzat24kLdO3o8ejmbLxyOac.jpg"),
        Movie(id: 2, title: "Black Widow", description: "Avengers", runTime: 134, releaseDate: "2021", url: "/qAZ0pzat24kLdO3o8ejmbLxyOac.jpg")
    ]
    @Published var movies = [String: [Movie]]()
    
    func fetchMovies() {
        
        for param in params {
            let url = "https://api.themoviedb.org/3/movie/\(param)?api_key=\(apiKey ?? "")"
            
            AF.request(url)
                .validate()
                .responseDecodable(of: Movies.self) { response in
                    guard let result = response.value else { return }
                    DispatchQueue.main.async { [self] in
                        movies[param] = result.all
                    }
                }
        }
    }
}
