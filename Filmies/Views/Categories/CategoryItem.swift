//
//  CategoryItem.swift
//  Filmies
//
//  Created by bryan colin on 7/9/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct CategoryItem: View {
    
    @EnvironmentObject var modelData: ModelData
    @State private var showingModal = false
    
    var film: Film 
    var category: String
    
    var width: CGFloat = 150
    var height: CGFloat = 220
    
    var releaseDate: String {
        if let movie = film as? Movie {
            return movie.releaseYear
        } else if let tvShow = film as? TvShow {
            return tvShow.firstAir
        }
        return ""
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Button(action: {
                if !modelData.isLoading {
                    showingModal.toggle()
                }
            }) {
                CustomImage(urlString: film.posterUrl)
                    .frame(width: width, alignment: .leading)
                    .cornerRadius(8)
                    .overlay(
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
                        .frame(maxHeight: .infinity),
                        alignment: .topLeading
                    )
            }
        }
        .padding(.leading, 15)
        .sheet(isPresented: $showingModal) {
            ModalView(film: film, category: category, showModal: self.$showingModal)
                .environmentObject(modelData)
        }
    }
}
