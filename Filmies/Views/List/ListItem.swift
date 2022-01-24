//
//  ListItem.swift
//  Filmies
//
//  Created by bryan colin on 8/18/21.
//

import SwiftUI


struct ListItem: View {
    
    //MARK: - PROPERTIES
    
    @EnvironmentObject var modelData: ModelData
    
    var film: Film
    var category: String
    
    @Binding var isToggle: Bool
    
    private var title: String {
        if let tvShow = film as? TvShow {
            return tvShow.name ?? ""
        }
        return film.title ?? ""
    }
    
    private var releaseDate: String {
        if let movie = film as? Movie {
            return movie.releaseYear
        } else if let tvShow = film as? TvShow {
            return tvShow.firstAir
        }
        return ""
    }
    
    //MARK: - BODY
    
    var body: some View {
        HStack(alignment: .top) {
            if !isToggle {
                CategoryItem(film: film, category: category)
                    .padding(.horizontal, -10)
                
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.title3)
                        .fontWeight(.bold)
                        .lineLimit(2)
                    
                    Text(releaseDate.toDate().toString(format: K.DateFormat.defaultOne))
                        .font(.caption)
                        .fontWeight(.regular)
                        .lineLimit(1)
                        .padding(.vertical, 5)
                    
                    Text(film.description)
                        .font(.headline)
                        .lineLimit(3)
                        .opacity(0.5)
                } //: VSTACK
                .padding(.vertical)
                .padding(.leading, 10)
            } else {
                BackdropView(film: film, category: category)
            }
        } //: HSTACK
    }
}

//MARK: - PREVIEW

struct ListItem_Previews: PreviewProvider {
    static var previews: some View {
        ListItem(film: Film.getPlaceholderData()[0], category: "movie/now_playing", isToggle: .constant(false))
            .environmentObject(ModelData())
    }
}
