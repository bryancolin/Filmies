//
//  ModalView.swift
//  Filmies
//
//  Created by bryan colin on 7/13/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct FilmView: View {
    
    //MARK: - PROPERTIES
    
    @EnvironmentObject var modelData: ModelData
    
    var film: Film
    var category: String
    private let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    
    @State var imageIndex = 0
    @State var isFavorite: Bool = false
    
    var filmTitle: String {
        if let tvShow = film as? TvShow {
            return tvShow.name ?? ""
        }
        return film.title ?? ""
    }
    
    var filmType: String { return film is Movie ? K.Movie.favorites : K.Tv.favorites }
    
    var posters: String? {
        if let posters = film.images?.posters, posters.count != 0 {
            return posters[imageIndex].filePath
        }
        return film.posterPath
    }
    
    var transition: AnyTransition {
        switch imageIndex {
        case 0:
            return .asymmetric(insertion: .scale, removal: .opacity)
        default:
            return .identity
        }
    }
    
    //MARK: - BODY
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                // HEAD VIEW
                VStack(spacing: 0) {
                    // TRAILER
                    FilmTrailer(film: film)

                    // TITLE
                    TitleComponent(name: filmTitle, color: .white, type: .title3, weight: .semibold) {
                        IconButton(title: !isFavorite ? "checkmark.circle" : "checkmark.circle.fill") {
                            isFavorite.toggle()
                            modelData.highlightFilm(type: filmType, check: isFavorite)
                        }
                        .foregroundColor(.white)
                    }
                }
                .background(Color.black.opacity(0.75))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                // SUB VIEW
                FilmDetails(film: film)
            } //: VSTACK
        } // SCROLLVIEW
        .background (
            CustomImage(urlPath: posters, ratio: .fill)
                .ignoresSafeArea()
                .transition(transition)
                .animation(.spring(), value: imageIndex)
                .onReceive(timer) { _ in
                    if let posters = film.images?.posters?.count, posters != 0 {
                        self.imageIndex = (self.imageIndex + 1) % posters
                    }
                }
        )
        .task {
            if let movie = film as? Movie, movie.details == nil {
                await modelData.fetchFilmDetails(type: .movie, expecting: Movie.self)
            } else if let tvShow = film as? TvShow, tvShow.details == nil {
                await modelData.fetchFilmDetails(type: .tvShow, expecting: TvShow.self)
            }
        }
        .onAppear {
            modelData.selectedCategory = category
            modelData.selectedFilmId = film.id ?? 0
            isFavorite = modelData.findFilm(param: filmType, id: film.id ?? 0).0
        }
    }
}

//MARK: - PREVIEW

struct FilmView_Previews: PreviewProvider {
    static var previews: some View {
        FilmView(film: Film.getPlaceholderData()[0], category: "movie/now_playing")
            .environmentObject(ModelData())
    }
}
