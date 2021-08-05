//
//  FilmTrailer.swift
//  Filmies
//
//  Created by bryan colin on 7/28/21.
//

import SwiftUI

struct FilmTrailer: View {
    
    @EnvironmentObject var modelData: ModelData
    
    var film: Film
    var category: String
    
    var body: some View {
        if let officialTrailers = film.videos?.all?.filter({ trailer -> Bool in
            guard let trailerName = trailer.name else { return false }
            return trailerName.contains("Trailer")
        }) {
            if !officialTrailers.isEmpty {
                VStack {
                    if officialTrailers.count > 1 && category != K.MovieCategory.favorites {
                        PageView(pages: officialTrailers.compactMap({ WebPlayerView(urlString: $0.youtubeURL, loadOnce: true) }), alignment: .topTrailing)
                    } else {
                        WebPlayerView(urlString: officialTrailers.first?.youtubeURL, loadOnce: true)
                    }
                }
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3, alignment: .top)
            } else {
                CustomImage(urlString: film.backdropUrl.isEmpty ? film.posterUrl : film.backdropUrl)
            }
        }
    }
}