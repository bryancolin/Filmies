//
//  MovieTrailer.swift
//  Filmies
//
//  Created by bryan colin on 7/28/21.
//

import SwiftUI

struct MovieTrailer: View {
    
    var movie: Movie
    
    var body: some View {
        if let trailers = movie.videos?.all, !trailers.isEmpty {
            VStack {
                let officialTrailers = trailers.filter { trailer -> Bool in
                    guard let trailerName = trailer.name else { return false }
                    return trailerName.contains("Trailer")
                }
                
                if officialTrailers.count == 1 {
                    WebPlayerView(urlString: officialTrailers.first?.youtubeURL, loadOnce: true)
                } else {
                    PageView(pages: officialTrailers.compactMap({ WebPlayerView(urlString: $0.youtubeURL, loadOnce: true) }), alignment: .topTrailing)
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3, alignment: .top)
        } else {
            CustomImage(urlString: movie.imageURL)
        }
    }
}
