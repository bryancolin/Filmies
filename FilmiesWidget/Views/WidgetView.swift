//
//  WidgetView.swift
//  FilmiesWidgetExtension
//
//  Created by bryan colin on 9/25/21.
//

import SwiftUI

struct WidgetView: View {
    
    var entry: Model
    
    @Environment(\.widgetFamily) var family
    
    var body: some View {
        let columns = Array(repeating: GridItem(.flexible()), count: 5)
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(K.BrandColors.blue), Color(K.BrandColors.purple)]), startPoint: .top, endPoint: .bottom)
            
            VStack(alignment: .leading) {
                Text("Trending")
                    .foregroundColor(Color(K.BrandColors.pink))
                
                switch family {
                case .systemSmall:
                    HStack {
                        ForEach(0..<2) { index in
                            if let details = entry.data, index < details.count {
                                NetworkImage(urlString: details[index].posterURL)
                                    .cornerRadius(5)
                            }
                        }
                    }
                    
                case .systemMedium:
                    LazyVGrid(columns: columns) {
                        ForEach(0..<5) { index in
                            if let details = entry.data, index < details.count {
                                NetworkImage(urlString: details[index].posterURL)
                                    .cornerRadius(5)
                            }
                        }
                    }
                    
                    
                case .systemLarge:
                    LazyVGrid(columns: columns) {
                        ForEach(0..<15) { index in
                            if let details = entry.data, index < details.count  {
                                NetworkImage(urlString: details[index].posterURL)
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
    
    let urlString: String
    
    var body: some View {
        if let url = URL(string: urlString), let imageData = try? Data(contentsOf: url), let uiImage = UIImage(data: imageData) {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}

