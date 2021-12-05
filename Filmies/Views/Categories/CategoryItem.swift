//
//  CategoryItem.swift
//  Filmies
//
//  Created by bryan colin on 7/9/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct CategoryItem: View {
    
    //MARK: - PROPERTIES
    
    @EnvironmentObject var modelData: ModelData
    @State private var showingModal = false
    
    var film: Film
    var category: String
    var width: CGFloat = 150
    
    var releaseDate: String {
        if let movie = film as? Movie {
            return movie.releaseYear
        } else if let tvShow = film as? TvShow {
            return tvShow.firstAir
        }
        return ""
    }
    
    //MARK: - BODY
    
    var body: some View {
        Button(action: {
            if !modelData.isLoading {
                showingModal.toggle()
            }
        }) {
            CustomImage(urlPath: film.posterPath)
                .frame(width: width, alignment: .leading)
                .cornerRadius(8)
                .overlay(alignment: .topLeading) {
                    GeometryReader { geometry in
                        let fontSize = min(9, geometry.size.width * 0.2)
                        let circleWidth = min(50, geometry.size.width * 0.2)
                        
                        Circle()
                            .frame(width: circleWidth, height: circleWidth)
                            .foregroundColor(Color(K.BrandColors.pink))
                            .overlay(
                                Text(releaseDate)
                                    .font(.system(size: fontSize))
                                    .foregroundColor(.white)
                            )
                            .padding(5)
                    }
                }
        } //: BUTTON
        .sheet(isPresented: $showingModal) {
            FilmView(film: film, category: category)
                .environmentObject(modelData)
        }
    }
}

//MARK: - PREVIEW

struct CategoryItem_Previews: PreviewProvider {
    static var previews: some View {
        CategoryItem(film: Film.getPlaceholderData()[0], category: "movie/now_playing")
            .environmentObject(ModelData())
    }
}
