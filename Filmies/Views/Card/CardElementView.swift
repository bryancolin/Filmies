//
//  CardElementView.swift
//  Filmies
//
//  Created by bryan colin on 7/13/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct CardElementView: View {
    
    @EnvironmentObject var modelData: ModelData
    
    @State private var showingModal = false
    
    var movie: Movie
    var category: String
    
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        CustomImage(urlString: movie.posterUrl)
            .frame(width: width, height: height)
            .overlay(
                Button(action: {
                    showingModal.toggle()
                }) {
                    Text("View")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 25)
                        .background(Color(K.BrandColors.pink))
                        .clipShape(Capsule())
                }
                .padding(),
                alignment: .bottomLeading
            )
            .sheet(isPresented: $showingModal) {
                ModalView(movie: movie, category: category, showModal: self.$showingModal)
                    .environmentObject(modelData)
            }
            .cornerRadius(15)
    }
}
