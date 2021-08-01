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
            Button(action: {
                if !modelData.isLoading {
                    showingModal.toggle()
                }
            }, label: {
                CustomImage(urlString: movie.posterUrl)
                    .frame(width: width, alignment: .leading)
                    .cornerRadius(8)
                    .overlay(
                        Circle()
                            .frame(width: 25, height: 25)
                            .foregroundColor(Color(K.BrandColors.pink))
                            .overlay(
                                Text(movie.releaseYear)
                                    .font(.system(size: 9))
                                    .foregroundColor(.white)
                            )
                            .padding(EdgeInsets(top: 5, leading: 5, bottom: 0, trailing: 0)),
                        alignment: .topLeading
                    )
            })
        }
        .padding(.leading, 15)
        .padding(.vertical)
        .sheet(isPresented: $showingModal) {
            ModalView(movie: movie, category: category, showModal: self.$showingModal)
                .environmentObject(modelData)
        }
    }
}
