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
    
    @Published var movies = [Movie]()
    @Published var sampleMovies = [
        Movie(id: 1, title: "Black Widow", description: "Avengers", runTime: 134, releaseDate: "2021", url: "/qAZ0pzat24kLdO3o8ejmbLxyOac.jpg")
    ]
    @Published var nowPlayingMovies = [Movie]()
    @Published var popularMovies = [Movie]()
    @Published var topRatedMovies = [Movie]()
    @Published var upcomingMovies = [Movie]()
    
    func fetchMovies(_ type: String) {
        let url = "https://api.themoviedb.org/3/movie/\(type)?api_key=\(apiKey ?? "")"
        
        AF.request(url)
            .validate()
            .responseDecodable(of: Movies.self) { response in
                guard let result = response.value else { return }
                DispatchQueue.main.async { [self] in
                    categorizeMovies(with: type, result)
                }
            }
    }
    
    func categorizeMovies(with type: String, _ result: Movies) {
        switch type {
        case "now_playing":
            nowPlayingMovies = result.all
        case "popular":
            popularMovies = result.all
        case "top_rated":
            topRatedMovies = result.all
        case "upcoming":
            upcomingMovies = result.all
        default:
            sampleMovies = result.all
        }
    }
}
