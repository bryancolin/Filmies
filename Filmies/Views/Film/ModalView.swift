//
//  ModalView.swift
//  Filmies
//
//  Created by bryan colin on 7/13/21.
//

import SwiftUI

struct ModalView: View {
    
    @EnvironmentObject var modelData: ModelData
    
    var film: Film
    var category: String
    @Binding var showModal: Bool
    
    @State var isFavorite: Bool = false
    
    @State var imageIndex = 0
    private let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    
    var filmTitle: String {
        if let tvShow = film as? TvShow {
            return tvShow.name ?? ""
        }
        return film.title ?? ""
    }
    
    var filmType: String {
        return film is Movie ? K.Movie.favorites : K.Tv.favorites
    }
    
    var transition: AnyTransition {
        switch imageIndex {
        case 0:
            return .asymmetric(insertion: .scale, removal: .opacity)
        default:
            return .identity
        }
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                // Head View
                VStack(spacing: 0) {
                    // Video Trailer
                    FilmTrailer(film: film, category: category)
                    
                    // Title Description
                    TitleComponent(name: filmTitle, color: .white, type: .title3, weight: .semibold) {
                        Button(action: {
                            isFavorite.toggle()
                            modelData.highlightFilm(type: filmType, param: film.category, id: film.id ?? 0, check: isFavorite)
                        }) {
                            Image(systemName: !isFavorite ? "checkmark.circle" : "checkmark.circle.fill")
                                .foregroundColor(.white)
                        }
                    }
                }
                .background(Color.black.opacity(0.75))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                // Sub View
                FilmDetails(film: film)
            }
        }
        .background (
            CustomImage(urlString: film.getPosters(at: imageIndex))
                .ignoresSafeArea()
                .transition(transition)
                .animation(.spring(), value: imageIndex)
                .onReceive(timer) { _ in
                    if let posters = film.images?.postersCount, posters != 0 {
                        self.imageIndex = (self.imageIndex + 1) % posters
                    }
                }
        )
        .task {
            if let movie = film as? Movie, movie.details == nil {
                await modelData.fetchFilmDetails(type: .movie, param: category, id: movie.id ?? 0, expecting: Movie.self)
            } else if let tvShow = film as? TvShow, tvShow.details == nil {
                await modelData.fetchFilmDetails(type: .tvShow, param: category, id: tvShow.id ?? 0, expecting: TvShow.self)
            }
        }
        .onAppear {
            isFavorite = modelData.findFilm(param: filmType, id: film.id ?? 0).0
        }
    }
}
