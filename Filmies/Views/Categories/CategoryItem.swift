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
    
    var movie: Movie
    var category: String
    
    var width: CGFloat = 150
    var height: CGFloat = 220
    
    var body: some View {
        VStack(alignment: .leading) {
            WebImage(url: URL(string: movie.imageURL))
                .resizable()
                .frame(width: width, height: height, alignment: .leading)
                .cornerRadius(8)
                .overlay(
                    Circle()
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color("BrandPink"))
                        .overlay(
                            Text(movie.releaseYear)
                                .font(.system(size: 9))
                                .foregroundColor(.white)
                        )
                        .padding(EdgeInsets(top: 5, leading: 5, bottom: 0, trailing: 0))
                    , alignment: .topLeading)
        }
        .padding(.leading, 15)
        .padding(.vertical)
        .onTapGesture {
            if movie.details == false {
                modelData.fetchMovieDetails(param: category, id: movie.id)
            }
            showingModal.toggle()
        }
        .sheet(isPresented: $showingModal) {
            ModalView(movie: movie, category: category, showModal: self.$showingModal)
                .environmentObject(modelData)
        }
    }
}

struct CategoryItem_Previews: PreviewProvider {
    static var previews: some View {
        CategoryItem(movie: ModelData().sampleMovies[0], category: "category")
            .environmentObject(ModelData())
            .previewLayout(.sizeThatFits)
    }
}
