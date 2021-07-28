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
                if trailers.count == 1 {
                    WebPlayerView(urlString: trailers.first?.youtubeURL, loadOnce: true)
                } else {
                    let fiveTrailers = trailers.enumerated().compactMap { $0 < 5 ? $1.youtubeURL : nil }
                    PageView(pages: fiveTrailers.compactMap({ WebPlayerView(urlString: $0, loadOnce: true) }), alignment: .topTrailing)
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3, alignment: .top)
        } else {
            CustomImage(urlString: movie.imageURL)
        }
    }
}
