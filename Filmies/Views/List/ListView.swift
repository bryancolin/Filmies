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
    @Binding var searchText: String
    
    @State private var numberOfColumns = 2

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
                    }
                    .padding()
                    
                    // Title
                    TitleComponent(name: title, color: .white, type: .largeTitle, weight: .bold) {
                        Button(action: {
                            numberOfColumns = numberOfColumns % 2 + 1
                        }) {
                            Image(systemName: ((numberOfColumns % 2) != 0)  ? "rectangle.grid.1x2.fill" : "square.grid.2x2.fill")
                        }
                    }
                    
                    // Cards
                    if let films = modelData.films[category] {
                        ForEach(films) {
                            ListItem(film: $0, category: category)
                        }
                        
                        // Load More
                        if films.count % 20 == 0 && !category.contains("favorites") {
                            Button(action: {
                                Task {
                                    await modelData.fetchFilms(with: category, name: searchText, pageNumber: (films.count / 20) + 1)
                                }
                            }) {
                                Text("Load more")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(K.BrandColors.pink))
                                    .frame(maxWidth: .infinity)
                            }
                            .tint(.white)
                            .buttonStyle(.bordered)
                            .controlSize(.large)
                            .padding()
                        }
                    } else if modelData.isError {
                        Text("Not Found")
                            .font(.caption)
                            .padding(.horizontal)
                    }
                }
            }
        }
    }
}

struct ListItem_Previews: PreviewProvider {
    static var previews: some View {
        ListView(title: "Now Playing", category: "movie/now_playing", searchText: .constant(""))
            .environmentObject(ModelData())
    }
}
