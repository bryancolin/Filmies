//
//  ModalView.swift
//  Filmies
//
//  Created by bryan colin on 7/13/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct ModalView: View {
    
    var movie: Movie
    @Binding var showModal: Bool
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                HStack {
                    Text(movie.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Text(movie.releaseYear)
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            
                        Text(movie.duration)
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                }
                .padding(.horizontal)
                .padding(.vertical)
                
                WebImage(url: URL(string: movie.imageURL))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(RoundedCorner(radius: 8, corners: [.bottomLeft, .bottomRight]))
                    
            }
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(Color(.white).opacity(0.32))
            )
            
            VStack {
//                ScrollTab(titles: ["Overview", "Casts"])
                
                Text(movie.description)
                    .font(.body)
                    .padding(.horizontal)
                    .padding(.vertical)
            }
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [Color("BrandPurple"), Color("BrandPink")]), startPoint: .leading, endPoint: .trailing)
                .ignoresSafeArea()
        )
    }
}


