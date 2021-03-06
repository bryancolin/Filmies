//
//  WidgetView.swift
//  FilmiesWidgetExtension
//
//  Created by bryan colin on 9/25/21.
//

import SwiftUI

struct WidgetView: View {
    
    @Environment(\.widgetFamily) var family
    
    var entry: Model
    var title: String {
        if let film = entry.data.first, film is Movie {
            return "Movies"
        } else {
            return "TV Shows"
        }
    }
    
    var body: some View {
        let columns = Array(repeating: GridItem(.flexible()), count: 5)
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(K.BrandColors.blue), Color(K.BrandColors.purple)]), startPoint: .top, endPoint: .bottom)
            
            VStack(alignment: .leading) {
                Text("Trending (\(title))")
                    .foregroundColor(Color(K.BrandColors.pink))
                    .fontWeight(.bold)
                    .lineLimit(1)
                
                switch family {
                case .systemSmall:
                    HStack {
                        ForEach(0..<2) { index in
                            if let details = entry.data, index < details.count {
                                NetworkImage(urlString: details[index].posterPath)
                                    .cornerRadius(5)
                            }
                        }
                    }
                    
                case .systemMedium:
                    LazyVGrid(columns: columns) {
                        ForEach(0..<5) { index in
                            if let details = entry.data, index < details.count {
                                NetworkImage(urlString: details[index].posterPath)
                                    .cornerRadius(5)
                            }
                        }
                    }
                    
                    
                case .systemLarge:
                    LazyVGrid(columns: columns) {
                        ForEach(0..<15) { index in
                            if let details = entry.data, index < details.count  {
                                NetworkImage(urlString: details[index].posterPath)
                                    .cornerRadius(5)
                            }
                        }
                    }
                    
                case .systemExtraLarge:
                    Text("Extra Large")
                    
                @unknown default:
                    Text("Error")
                }
                
            }
            .padding()
        }
    }
}

struct NetworkImage: View {
    
    let urlString: String?
    
    var body: some View {
        if let urls = urlString, let url = URL(string: "https://image.tmdb.org/t/p/w500" + urls) {
            if let imageData = try? Data(contentsOf: url), let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
    }
}

