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
    @State var selectedIndex = 0
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                // Head View
                VStack(spacing: 0) {
                    // Video Trailer
                    MovieTrailer(movie: movie)
                    
                    // Title Description
                    LargeTitle(name: movie.title ?? "", color: .white, type: .title3, weight: .semibold) {
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
                VStack(alignment: .leading) {
                    ScrollTabView(titles: ["Overview", "Casts"], index: $selectedIndex, color: CustomColor.secondary)
                    
                    if selectedIndex == 0 {
                        MovieDetails(movie: movie, version: 1)
                    } else {
                        MovieDetails(movie: movie, version: 2)
                    }
                }
                .padding(.vertical)
                .background(Color.black.opacity(0.75))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
        .background(
            CustomImage(urlString: movie.imageURL)
                .ignoresSafeArea()
        )
        .onAppear {
            if movie.details == false {
                modelData.fetchMovieDetails(param: category, id: movie.id ?? 0)
            }
            isFavorite = modelData.findMovie(param: "favorites", id: movie.id ?? 0).0
        }
    }
}

