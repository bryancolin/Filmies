//
//  FilmTrailer.swift
//  Filmies
//
//  Created by bryan colin on 7/28/21.
//

import SwiftUI

struct FilmTrailer: View {
    
    //MARK: - PROPERTIES
    
    @EnvironmentObject var modelData: ModelData
    
    var film: Film
    
    //MARK: - BODY
    
    var body: some View {
        if let officialTrailers = film.videos?.getVideos(name: "Trailer"), !officialTrailers.isEmpty {
            VStack {
                if officialTrailers.count > 1 {
                    PageView(pages: officialTrailers.compactMap{ WebPlayerView(key: $0.key, loadOnce: true)}, alignment: .topTrailing)
                } else {
                    WebPlayerView(key: officialTrailers.first?.key, loadOnce: true)
                }
            } //: VSTACK
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3, alignment: .top)
        } else {
            CustomImage(urlPath: (film.backdropPath != nil) ? film.backdropPath : film.posterPath)
        }
    }
}

//MARK: - PREVIEW

struct FilmTrailer_Previews: PreviewProvider {
    static var previews: some View {
        FilmTrailer(film: Film.getPlaceholderData()[0])
            .environmentObject(ModelData())
    }
}

