//
//  ModalView.swift
//  Filmies
//
//  Created by bryan colin on 7/13/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct ModalView: View {
    
    @EnvironmentObject var modelData: ModelData
    
    var movie: Movie
    var category: String
    @Binding var showModal: Bool
    @State var selectedIndex = 0
    
    init(movie: Movie, category: String, showModal: Binding<Bool>) {
        self.movie = movie
        self.category = category
        self._showModal = showModal
        
        UIScrollView.appearance().bounces = false
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                HStack {
                    Text(movie.title)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Text(movie.releaseYear)
                            .font(.caption2)
                            .foregroundColor(.white)
                        
                        Text(movie.duration ?? "")
                            .font(.caption2)
                            .foregroundColor(.white)
                    }
                }
                .padding(.horizontal)
                .padding(.vertical)
                
                WebImage(url: URL(string: movie.imageURL))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } 
            .background(Color.white.opacity(0.32))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            ScrollTabView(titles: ["Overview", "Casts"], index: $selectedIndex, color: CustomColor.secondary)
                .padding(.vertical, 10)
            
            VStack {
                Text(movie.description)
                    .font(.caption2)
                    .foregroundColor(.white)
            }
            .padding(.horizontal)
            .padding(.bottom, 20)
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [Color("BrandPurple"), Color("BrandPink")]), startPoint: .leading, endPoint: .trailing)
                .ignoresSafeArea()
        )
    }
}


