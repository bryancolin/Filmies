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
    
    var body: some View {
        if let officialTrailers = film.videos?.all?.filter({ trailer -> Bool in
            guard let trailerName = trailer.name else { return false }
            return trailerName.contains("Trailer")
        }) {
            if !officialTrailers.isEmpty {
                VStack {
                    if officialTrailers.count > 1 {
                        PageView(pages: officialTrailers.compactMap{ WebPlayerView(key: $0.key, loadOnce: true)}, alignment: .topTrailing)
                    } else {
                        WebPlayerView(key: officialTrailers.first?.key, loadOnce: true)
                    }
                }
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3, alignment: .top)
            } else {
                CustomImage(urlPath: (film.backdropPath != nil) ? film.backdropPath : film.posterPath)
            }
        }
    }
}
