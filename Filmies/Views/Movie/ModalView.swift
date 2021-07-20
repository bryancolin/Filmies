//
//  ModalView.swift
//  Filmies
//
//  Created by bryan colin on 7/13/21.
//

import SwiftUI
import AVKit
import SDWebImageSwiftUI

struct ModalView: View {
    
    @EnvironmentObject var modelData: ModelData
    
    var movie: Movie
    var category: String
    @Binding var showModal: Bool
    @State var selectedIndex = 0
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                // Video Trailer
                if let trailers = movie.videos?.all {
                    WebPlayerView(urlString: !trailers.isEmpty ? trailers.first?.youtubeURL : "https://www.youtube.com/embed/", loadOnce: true)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3, alignment: .top)
                        .background(Color.black)
                }
                
                // Title
                HStack {
                    Text(movie.title)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                    
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
            }
            .background(Color.black.opacity(0.5))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            // SubView
            ScrollTabView(titles: ["Overview", "Casts"], index: $selectedIndex, color: CustomColor.primary)
                .padding(.vertical, 10)
            
            VStack {
                Text(movie.description)
                    .font(.caption2)
                    .foregroundColor(.white)
            }
            .padding(.horizontal)
            .padding(.vertical)
            .background(Color.black.opacity(0.5))
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .background(
            WebImage(url: URL(string: movie.imageURL))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
        )
    }
}


