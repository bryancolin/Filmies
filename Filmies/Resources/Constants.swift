//
//  Constants.swift
//  Filmies
//
//  Created by bryan colin on 7/20/21.
//

import Foundation

enum K {
    
    enum DateFormat {
        static let day = "EEEE"
        static let defaultOne = "dd MMMM yyyy"
    }
    
    enum Settings {
        static let selectedFilmType = "filmType"
        static let onboarding = "onboarding"
    }
    
    enum FileDocument {
        static let movieKey = "FavoriteMovies"
        static let tvKey = "FavoriteTvShows"
    }
    
    enum Movie {
        static let daily = "trending/movie/day"
        static let weekly = "trending/movie/week"
        static let nowPlaying = "movie/now_playing"
        static let topRated = "movie/top_rated"
        static let popular = "movie/popular"
        static let upcoming = "movie/upcoming"
        static let favorites = "movie/favorites"
    }
    
    enum Tv {
        static let daily = "trending/tv/day"
        static let weekly = "trending/tv/week"
        static let airingToday = "tv/airing_today"
        static let topRated = "tv/top_rated"
        static let popular = "tv/popular"
        static let onAir = "tv/on_the_air"
        static let favorites = "tv/favorites"
    }
    
    enum People {
        static let movie = "person/movie"
        static let tv = "person/tv"
    }
    
    enum BrandColors {
        static let blue = "BrandBlue"
        static let darkBlue = "BrandDarkBlue"
        static let pink = "BrandPink"
        static let purple = "BrandPurple"
    }
}
