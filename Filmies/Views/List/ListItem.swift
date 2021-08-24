//
//  ListItem.swift
//  Filmies
//
//  Created by bryan colin on 8/18/21.
//

import SwiftUI


struct ListItem: View {
    
    @EnvironmentObject var modelData: ModelData
    
    var film: Film
    var category: String
    
    private var title: String {
        if let tvShow = film as? TvShow {
            return tvShow.name ?? ""
        }
        return film.title ?? ""
    }
    
    private var releaseDate: String {
        if let movie = film as? Movie {
            return movie.releaseDate?.toDate().toString(format: K.dateFormat) ?? ""
        } else if let tvShow = film as? TvShow {
            return tvShow.firstAirDate?.toDate().toString(format: K.dateFormat) ?? ""
        } else {
            return ""
        }
    }
    
    var body: some View {
        HStack(alignment: .top) {
            CategoryItem(film: film, category: category)
                .padding(.leading, -15)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.title3)
                    .fontWeight(.bold)
                    .lineLimit(2)
                
                Text(releaseDate)
                    .font(.caption)
                    .fontWeight(.regular)
                    .lineLimit(1)
                    .padding(.vertical, 5)
                
                Text(film.description)
                    .font(.headline)
                    .lineLimit(3)
                    .opacity(0.5)
            }
            .padding()
        }
        .background(Color.white.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding(.horizontal)
        .redacted(reason: modelData.isLoading ? .placeholder : [])
    }
}
