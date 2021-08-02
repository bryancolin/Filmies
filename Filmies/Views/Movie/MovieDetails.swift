//
//  MovieDetails.swift
//  Filmies
//
//  Created by bryan colin on 7/24/21.
//

import SwiftUI

struct MovieDetails: View {
    
    @EnvironmentObject var modelData: ModelData
    
    var movie: Movie
    
    @State var index  = 0
    
    var body: some View {
        TabView(selection: $index) {
            VStack(alignment: .leading, spacing: 10) {
                RoundedText(title: "Overview", id: 0, selectedIndex: .constant(0), color: .secondary)
                
                Text(movie.description ?? "")
                    .foregroundColor(.white)
                    .font(.caption)
                    .fixedSize(horizontal: false, vertical: true)
                
                CustomDivider()
                
                HorizontalComponent(title: "Rating", details: [movie.rate])
                
                HorizontalComponent(title: "Release Date", details: [movie.releaseDate?.toDate().toString(format: "dd/MM/yyyy") ?? ""])
                
                HorizontalComponent(title: "Runtime", details: [movie.duration ?? ""])
                
                if let languages = movie.languages {
                    HorizontalComponent(title: "Languages", details: languages.compactMap( { $0.name }))
                }
                
                if let genres = movie.genres {
                    HorizontalComponent(title: "Genres", details: genres.compactMap( { $0.name }))
                }
                
//                HorizontalComponent(title: "Added Day", details: [movie.addedDate.dateAndTimetoString()])
                
                Spacer()
            }.tag(0)
            
            VStack(alignment: .leading, spacing: 10) {
                RoundedText(title: "Casts", id: 0, selectedIndex: .constant(0), color: .secondary)
                
                if let casts = movie.casts {
                    if let crews = casts.crewCategories["Director"] {
                        VerticalComponent(title: "Director", urls: crews.compactMap({ $0.imageURL }), details: crews.compactMap({ $0.name }))
                    }
                    
                    if let crews = casts.crewCategories["Writer"] {
                        VerticalComponent(title: "Writer", urls: crews.compactMap({ $0.imageURL }), details: crews.compactMap({ $0.name }))
                    }
                    
                    if let actors = casts.cast {
                        VerticalComponent(title: "Starring", urls: actors.compactMap({ $0.imageURL }), details: actors.compactMap({ $0.name }))
                    }
                }
                
                Spacer()
            }.tag(1)
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .frame(height: UIScreen.main.bounds.height + 100)
        .padding()
        .background(Color.black.opacity(0.75))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(
            PageControl(numberOfPages: 2, currentpage: $index)
                .frame(width: CGFloat(2 * 18))
                .padding(),
            alignment: .topTrailing
        )
    }
}

struct HorizontalComponent: View {
    
    var title: String
    var details: [String]
    
    var body: some View {
        HStack(alignment: .top) {
            Text(title)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            
            Spacer()
            
            VStack(alignment: .trailing) {
                ForEach(0..<5) { index in
                    if index < details.count {
                        Text(details[index])
                            .foregroundColor(.white)
                    }
                }
            }
        }
    }
}

struct VerticalComponent: View {
    
    var title: String
    var urls: [String]
    var details: [String]
    
    var body: some View {
        
        CustomDivider()
        
        VStack(alignment: .leading) {
            Text(title)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 10) {
                    ForEach(0..<5) { index in
                        if index < details.count {
                            VStack(alignment: .leading) {
                                CustomImage(urlString: urls[index], placeholder: "user")
                                    .frame(width: 75, height: 75)
                                    .cornerRadius(50)
                                
                                Text(details[index])
                                    .foregroundColor(.white)
                                    .frame(width: 75)
                                    .font(.caption)
                                    .lineLimit(2)
                                    .minimumScaleFactor(0.5)
                            }
                        }
                    }
                }
            }
        }
    }
}

