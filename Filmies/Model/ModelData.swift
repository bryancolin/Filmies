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
    var params = ["day", "week", "now_playing", "popular", "upcoming", "top_rated"]
    
    @Published var sampleMovies = [
        Movie(id: 1, title: "Black Widow", description: "Avengers", runTime: 134, releaseDate: "2021", url: "/qAZ0pzat24kLdO3o8ejmbLxyOac.jpg"),
        Movie(id: 2, title: "Black Widow", description: "Avengers", runTime: 134, releaseDate: "2021", url: "/qAZ0pzat24kLdO3o8ejmbLxyOac.jpg")
    ]
    @Published var movies = [String: [Movie]]()
    
    func fetchMovies() {
        
        for (index, param) in params.enumerated() {
            let trend = (index == 0 || index == 1) ? "trending/" : ""
            let url = "https://api.themoviedb.org/3/\(trend)movie/\(param)?api_key=\(apiKey ?? "")"
            
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
