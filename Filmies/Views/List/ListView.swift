//
//  ListItem.swift
//  Filmies
//
//  Created by bryan colin on 8/12/21.
//

import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var modelData: ModelData
    @Environment(\.presentationMode) var presentationMode
    
    var title: String
    var category: String
    
    @State var scrollViewOffset: CGFloat = 0
    @State var startOffset: CGFloat = 0
    @State var isScrollToTop = false
    
    var background: some View {
        GlassmorphismBackground(type: .left, circleColors: .constant([Color(K.BrandColors.purple), Color(K.BrandColors.pink), Color(K.BrandColors.blue)]), backgroundColors: [Color.black], blurRadius: 100)
    }
    
    var body: some View {
        ZStack {
            // Background
            background
            // Component
            CustomScrollView {
                VStack(alignment: .leading) {
                    // Back Button
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.backward")
                            .font(.system(size: 25))
                    }
                    .padding()
                    
                    // Title
                    TitleComponent(name: title, color: .white, type: .largeTitle, weight: .bold, firstContent: {}, secondContent: {})
                    
                    // Cards
                    if let films = modelData.films[category] {
                        ForEach(films) {
                            ListItem(film: $0, category: category)
                        }
                        
                        // Load More
                        if films.count % 20 == 0 {
                            Button(action: {
                                modelData.fetchFilms(with: category, pageNumber: (films.count / 20) + 1)
                            }) {
                                RoundedRectangle(cornerRadius: 8)
                                    .frame(height: 50)
                                    .overlay(
                                        Text("Load more")
                                            .fontWeight(.bold)
                                            .foregroundColor(Color(K.BrandColors.pink))
                                    )
                            }
                            .padding()
                        }
                    }
                }
            }
        }
    }
}

struct ListItem_Previews: PreviewProvider {
    static var previews: some View {
        ListView(title: "Now Playing", category: "movie/now_playing")
            .environmentObject(ModelData())
    }
}

struct ListItem: View {
    
    @EnvironmentObject var modelData: ModelData
    
    var film: Film
    var category: String
    
    var title: String {
        if let tvShow = film as? TvShow {
            return tvShow.name ?? ""
        }
        return film.title ?? ""
    }
    
    var body: some View {
        HStack(alignment: .top) {
            CategoryItem(film: film, category: category)
                .padding(.leading, -15)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(.bottom, 5)
                
                Text(film.description)
                    .font(.subheadline)
                    .lineLimit(5)
                    .minimumScaleFactor(0.5)
            }
            .padding()
        }
        .background(Color.white.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding(.horizontal)
        .redacted(reason: modelData.isLoading ? .placeholder : [])
    }
}
