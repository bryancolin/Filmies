//
//  Constants.swift
//  Filmies
//
//  Created by bryan colin on 7/20/21.
//

import Foundation

struct K {
    
    static let dateFormat = "E, dd MMMM yyyy"
    
    struct UserDefaults {
        static let movieKey = "FavoriteMovies"
        static let tvKey = "FavoriteTvShows"
    }
    
    struct MovieCategory {
        static let favorites = "movie/favorites"
    }
    
    struct TvShowCategory {
        static let favorites = "tv/favorites"
    }
    
    struct BrandColors {
        static let blue = "BrandBlue"
        static let darkBlue = "BrandDarkBlue"
        static let pink = "BrandPink"
        static let purple = "BrandPurple"
    }
}
