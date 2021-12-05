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
    
    @Binding var numberOfColumns: Int
    
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
    
    //MARK: - BODY
    
    var body: some View {
        HStack(alignment: .top) {
            CategoryItem(film: film, category: category)
            
            if numberOfColumns % 2 != 0 {
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
                } //: VSTACK
                .padding()
            }
        } //: HSTACK
        .background(Color.white.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding(.horizontal)
        .redacted(reason: modelData.isLoading ? .placeholder : [])
    }
}

//MARK: - PREVIEW

struct ListItem_Previews: PreviewProvider {
    static var previews: some View {
        ListItem(film: Film.getPlaceholderData()[0], category: "movie/now_playing", numberOfColumns: .constant(1))
            .environmentObject(ModelData())
    }
}
