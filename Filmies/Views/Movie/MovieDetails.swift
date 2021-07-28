//
//  MovieDetails.swift
//  Filmies
//
//  Created by bryan colin on 7/24/21.
//

import SwiftUI

struct MovieDetails: View {
    
    @EnvironmentObject var modelData: ModelData
    
    var movie: Movie
    var version: Int
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            
            if version == 1 {
                
                Text(movie.description ?? "")
                    .foregroundColor(.white)
                    .font(.caption)
                    .fixedSize(horizontal: false, vertical: true)
                
                CustomDivider()
                
                HorizontalText(name: "Release Date", details: [movie.releaseDate ?? ""])
                
                HorizontalText(name: "Runtime", details: [movie.duration ?? ""])
                
                if let languages = movie.languages {
                    HorizontalText(name: "Languages", details: languages.compactMap( { $0.name }))
                }
                
                if let genres = movie.genres {
                    HorizontalText(name: "Genres", details: genres.compactMap( { $0.name }))
                }
                
            } else if version == 2 {
                
                if let casts = movie.casts {
                    if let crews = casts.crewCategories["Director"] {
                        HorizontalText(name: "Director", details: crews.compactMap( { $0.name }))
                    }
                    
                    if let crews = casts.crewCategories["Writer"] {
                        HorizontalText(name: "Writer", details: crews.compactMap( { $0.name }))
                    }
                    
                    if let actors = casts.cast {
                        HorizontalText(name: "Starring", details: actors.compactMap( { $0.name }))
                    }
                }
                
            }
        }
        .padding(.horizontal)
    }
}

struct HorizontalText: View {
    
    var name: String
    var details: [String]
    
    var body: some View {
        HStack(alignment: .top) {
            Text(name)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            
            Spacer()
            
            VStack(alignment: .trailing) {
                ForEach(0..<5) { index in
                    if index < details.count {
                        Text(details[index])
                            .foregroundColor(.white)
                    }
                }
            }
        }
    }
}

