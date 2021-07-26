//
//  MovieDetails.swift
//  Filmies
//
//  Created by bryan colin on 7/24/21.
//

import SwiftUI

struct MovieDetails: View {
    
    var movie: Movie
    
    var body: some View {
        Text(movie.description ?? "")
            .foregroundColor(.white)
            .font(.caption)
            .fixedSize(horizontal: false, vertical: true)
        
        CustomDivider()
        
        HorizontalText(name: "Release Date", details: movie.releaseDate ?? "")
        
        HorizontalText(name: "Runtime", details: movie.duration ?? "")
        
        if let languages = movie.languages {
            HStack(alignment: .top) {
                Text("Languages")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                Spacer()
                VStack(alignment: .trailing) {
                    ForEach(0..<5) { index in
                        if index < languages.count {
                            Text(languages[index].name ?? "")
                                .foregroundColor(.white)
                        }
                    }
                }
            }
        }
        
        if let genres = movie.genres {
            HStack(alignment: .top) {
                Text("Genres")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                Spacer()
                VStack(alignment: .trailing) {
                    ForEach(0..<5) { index in
                        if index < genres.count {
                            Text(genres[index].name ?? "")
                                .foregroundColor(.white)
                        }
                    }
                }
            }
        }
    }
}

struct HorizontalText: View {
    
    var name: String
    var details: String
    
    var body: some View {
        HStack(alignment: .top) {
            Text(name)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            
            Spacer()
            
            Text(details)
                .foregroundColor(.white)
        }
    }
}

