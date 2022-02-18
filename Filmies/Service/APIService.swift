//
//  APIService.swift
//  Filmies
//
//  Created by bryan colin on 2/18/22.
//

import SwiftUI

final class APIService {
    
    // URL Details
    private let url = "https://api.themoviedb.org/3"
    private let apiKey = "?api_key=\(Bundle.main.infoDictionary?["API_KEY"] as? String ?? "")"
    
    // Fetch Films
    func getFilms(with param: String, name: String = "", pageNumber: Int = 1) async -> [Film]? {
        // Searching Films (Encoding Query)
        let urlName = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let query = name.isEmpty ? "" : "&query=\(urlName ?? "")"
        
        let fullURL = "\(url)/\(param)" + apiKey + query + "&page=\(pageNumber)"
        
        do {
            let result = try await URLSession.shared.request(url: URL(string: fullURL), expecting: Films.self)
            return result.all
        } catch {
            print(error)
        }
        
        return nil
    }
    
    // Fetch Films Details
    func getFilmDetails<T: Codable>(filmId: Int, type: String, expecting: T.Type) async -> Film? {
        let fullURL = "\(url)/\(type)/\(filmId)" + apiKey + "&append_to_response=videos,casts,credits,images&include_image_language=en"
        
        do {
            let result = try await URLSession.shared.request(url: URL(string: fullURL), expecting: expecting)
            return (result as? Film)
        } catch {
            print(error)
        }
        
        return nil
    }
    
    // Fetch Season Episodes
    func getEpisodes(filmId: Int, seasonId: Int) async -> [Episode]? {
        let fullURL = "\(url)/tv/\(filmId)/season/\(seasonId)" + apiKey
        
        do {
            let result = try await URLSession.shared.request(url: URL(string: fullURL), expecting: Season.self)
            return result.episodes
        } catch {
            print(error)
        }
        
        return nil
    }
    
    // Fetch People
    func getPeople(id: Int) async -> People? {
        let fullURL = "\(url)/person/\(id)" + apiKey + "&append_to_response=movie_credits,tv_credits&include_image_language=en"
        
        do {
            let result = try await URLSession.shared.request(url: URL(string: fullURL), expecting: People.self)
            return result
        } catch {
            print(error)
        }
        
        return nil
    }
}
