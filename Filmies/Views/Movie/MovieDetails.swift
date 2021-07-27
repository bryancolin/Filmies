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
        
        HorizontalText(name: "Release Date", details: [movie.releaseDate ?? ""])
        
        HorizontalText(name: "Runtime", details: [movie.duration ?? ""])
        
        if let languages = movie.languages {
            let details = languages.compactMap( { $0.name })
            HorizontalText(name: "Languages", details: details)
        }
        
        if let genres = movie.genres {
            let details = genres.compactMap( { $0.name })
            HorizontalText(name: "Genres", details: details)
        }
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

