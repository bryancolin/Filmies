//
//  MovieDetails.swift
//  Filmies
//
//  Created by bryan colin on 7/12/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieDetails: View {
    
    var movie: Movie
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("BrandPurple"), Color("BrandPink")]), startPoint: .leading, endPoint: .trailing)
                .ignoresSafeArea()
            ScrollView {
                VStack(spacing: 0) {
                    RoundedRectangle(cornerRadius: 0)
                        .frame(height: 90)
                        .foregroundColor(Color(.white).opacity(0.32))
                        .border(Color.white, width: 1)
                        .overlay(
                            HStack {
                                Text(movie.title)
                                    .foregroundColor(.white)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .padding(.leading, 20)
                                    .lineLimit(nil)
                                Spacer()
                                VStack(alignment: .trailing) {
                                    Text(movie.releaseYear)
                                        .foregroundColor(.white)
                                    Text(String(movie.duration))
                                        .foregroundColor(.white)
                                }
                                .padding(.trailing, 20)
                            }
                            .padding()
                        )
                    
                    WebImage(url: URL(string: movie.imageURL))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 600)
                        .background(
                            RoundedCorners(color: .clear, tl: 0, tr: 0, bl: 16, br: 16)
                        )
                        
                }
                
            }.edgesIgnoringSafeArea(.top)
        }
    }
}

struct MovieDetails_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetails(movie: ModelData().sampleMovies[0])
    }
}
