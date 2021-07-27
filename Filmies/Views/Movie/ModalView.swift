//
//  ModalView.swift
//  Filmies
//
//  Created by bryan colin on 7/13/21.
//

import SwiftUI
import AVKit

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
                    if let trailers = movie.videos?.all {
                        if !trailers.isEmpty {
                            WebPlayerView(urlString: trailers.first?.youtubeURL, loadOnce: true)
                                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3, alignment: .top)
                        } else {
                            CustomImage(urlString: movie.imageURL)
                        }
                    }
                    
                    // Title
                    HStack {
                        Text(movie.title ?? "")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .lineLimit(2)
                            .minimumScaleFactor(0.5)
                        
                        Spacer()
                        
                        Button(action: {
                            isFavorite.toggle()
                            modelData.highlightMovie(param: movie.category, id: movie.id ?? 0, check: isFavorite)
                        }, label: {
                            Image(systemName: !isFavorite ? "checkmark.circle" : "checkmark.circle.fill")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.white)
                        })
                    }
                    .padding(.horizontal)
                    .padding(.vertical)
                }
                .background(Color.black.opacity(0.75))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                // Sub View
                VStack(alignment: .leading) {
                    
                    ScrollTabView(titles: ["Overview", "Casts"], index: $selectedIndex, color: CustomColor.secondary)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        if selectedIndex == 0 {
                            
                            MovieDetails(movie: movie)
                            
                        } else if selectedIndex == 1 {
                            
                            if let casts = movie.casts {
                                if let crews = casts.crewCategories["Director"] {
                                    let details = crews.compactMap( { $0.name })
                                    HorizontalText(name: "Director", details: details)
                                }
                                
                                if let crews = casts.crewCategories["Writer"] {
                                    let details = crews.compactMap( { $0.name })
                                    HorizontalText(name: "Writer", details: details)
                                }
                                
                                if let actors = casts.cast {
                                    let details = actors.compactMap( { $0.name })
                                    HorizontalText(name: "Starring", details: details)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
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

