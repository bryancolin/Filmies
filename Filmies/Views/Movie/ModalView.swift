//
//  ModalView.swift
//  Filmies
//
//  Created by bryan colin on 7/13/21.
//

import SwiftUI

struct ModalView: View {
    
    @EnvironmentObject var modelData: ModelData
    
    var movie: Movie
    var category: String
    @Binding var showModal: Bool
    
    @State var isFavorite: Bool = false
    
    @State var imageIndex = 0
    private let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    
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
                    MovieTrailer(movie: movie, category: category)
                    
                    // Title Description
                    TitleComponent(name: movie.title ?? "", color: .white, type: .title3, weight: .semibold) {
                        Button(action: {
                            isFavorite.toggle()
                            modelData.highlightMovie(param: movie.category, id: movie.id ?? 0, check: isFavorite)
                        }, label: {
                            Image(systemName: !isFavorite ? "checkmark.circle" : "checkmark.circle.fill")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.white)
                        })
                    }
                }
                .background(Color.black.opacity(0.75))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                // Sub View
                MovieDetails(movie: movie)
            }
        }
        .background (
            CustomImage(urlString: movie.getPosters(at: imageIndex))
                .ignoresSafeArea()
                .transition(transition)
                .animation(.spring())
                .onReceive(timer) { _ in
                    if let posters = movie.images?.postersCount, posters != 0 {
                        self.imageIndex = (self.imageIndex + 1) % posters
                    }
                }
        )
        .onAppear {
            if movie.details == nil {
                modelData.fetchMovieDetails(param: category, id: movie.id ?? 0)
            }
            isFavorite = modelData.findMovie(param: K.MovieCategory.favorites, id: movie.id ?? 0).0
        }
    }
}

