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
                
                HorizontalComponent(title: "Release Date", details: [movie.releaseDate?.toDate().toString(format: "dd/MM/yyyy") ?? ""])
                
                HorizontalComponent(title: "Runtime", details: [movie.duration ?? ""])
                
                if let languages = movie.languages {
                    HorizontalComponent(title: "Languages", details: languages.compactMap( { $0.name }))
                }
                
                if let genres = movie.genres {
                    HorizontalComponent(title: "Genres", details: genres.compactMap( { $0.name }))
                }
                
                HorizontalComponent(title: "Added Day", details: [movie.addedDate.dateAndTimetoString()])
                
            } else if version == 2 {
                
                if let casts = movie.casts {
                    if let crews = casts.crewCategories["Director"] {
                        VerticalComponent(title: "Director", urls: crews.compactMap({ $0.imageURL }), details: crews.compactMap({ $0.name }))
                    }
                    
                    if let crews = casts.crewCategories["Writer"] {
                        VerticalComponent(title: "Writer", urls: crews.compactMap({ $0.imageURL }), details: crews.compactMap({ $0.name }))
                    }
                    
                    if let actors = casts.cast {
                        VerticalComponent(title: "Starring", urls: actors.compactMap({ $0.imageURL }), details: actors.compactMap({ $0.name }))
                    }
                }
                
            }
        }
        .padding(.horizontal)
    }
}

struct HorizontalComponent: View {
    
    var title: String
    var details: [String]
    
    var body: some View {
        HStack(alignment: .top) {
            Text(title)
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

struct VerticalComponent: View {
    
    var title: String
    var urls: [String]
    var details: [String]
    
    var body: some View {
        
        CustomDivider()
        
        VStack(alignment: .leading) {
            Text(title)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 10) {
                    ForEach(0..<5) { index in
                        if index < details.count {
                            VStack(alignment: .leading) {
                                CustomImage(urlString: urls[index])
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(16)
                                
                                Text(details[index])
                                    .foregroundColor(.white)
                                    .frame(width: 100)
                            }
                        }
                    }
                }
            }
        }
    }
}

