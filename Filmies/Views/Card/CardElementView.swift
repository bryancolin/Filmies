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
    
    @State var flipped: Bool = false
    @State var flip: Bool = false
    
    var movie: Movie
    var category: String
    
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        ZStack {
            WebImage(url: URL(string: movie.imageURL))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: width, height: height)
                .overlay(
                    ZStack() {
                        if flip {
                            Color.white.opacity(flip ? 0.5 : 0)
                            Button(action: {
                                showingModal.toggle()
                            }) {
                                Text("View")
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(.vertical, 6)
                                    .padding(.horizontal, 25)
                                    .background(Color("BrandPink"))
                                    .clipShape(Capsule())
                            }
                        }
                    }
                    , alignment: .bottomLeading
                )
                .modifier(FlipEffect(flipped: $flipped, angle: flip ? 0 : 180))
                .onTapGesture() {
                    withAnimation {
                        if movie.details == false {
                            modelData.fetchMovieDetails(param: category, id: movie.id)
                        }
                        flip.toggle()
                    }
                }
                .sheet(isPresented: $showingModal) {
                    ModalView(movie: movie, category: category, showModal: self.$showingModal)
                        .environmentObject(modelData)
                }
        }
        .cornerRadius(15)
    }
}
