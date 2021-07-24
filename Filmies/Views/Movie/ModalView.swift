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
                                    HStack(alignment: .top) {
                                        Text("Director")
                                            .fontWeight(.semibold)
                                            .foregroundColor(.white)
                                        Spacer()
                                        VStack(alignment: .trailing) {
                                            ForEach(0..<5) { index in
                                                if index < crews.count {
                                                    Text(crews[index].name ?? "")
                                                        .foregroundColor(.white)
                                                }
                                            }
                                        }
                                    }
                                }
                                
                                if let crews = casts.crewCategories["Writer"] {
                                    HStack(alignment: .top) {
                                        Text("Writer")
                                            .fontWeight(.semibold)
                                            .foregroundColor(.white)
                                        Spacer()
                                        VStack(alignment: .trailing) {
                                            ForEach(0..<5) { index in
                                                if index < crews.count {
                                                    Text(crews[index].name ?? "")
                                                        .foregroundColor(.white)
                                                }
                                            }
                                        }
                                    }
                                }
                                
                                if let actors = casts.cast {
                                    HStack(alignment: .top) {
                                        Text("Starring")
                                            .fontWeight(.semibold)
                                            .foregroundColor(.white)
                                        Spacer()
                                        VStack(alignment: .trailing) {
                                            ForEach(0..<5) { index in
                                                if index < actors.count {
                                                    Text(actors[index].name ?? "")
                                                        .foregroundColor(.white)
                                                }
                                            }
                                        }
                                    }
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
        }
    }
}

