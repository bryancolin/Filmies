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
    
    @State private var numberOfColumns = 1
    
    var background: some View {
        GlassmorphismBackground(type: .left, circleColors: .constant([Color(K.BrandColors.purple), Color(K.BrandColors.pink), Color(K.BrandColors.blue)]), backgroundColors: [Color.black], blurRadius: 100)
    }
    
    var body: some View {
        let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: numberOfColumns)
        
        ZStack {
            // Background
            background
            // Component
            CustomScrollView {
                VStack(alignment: .leading) {
                    // Back Button
                    IconButton(title: "arrow.backward") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .padding()
                    
                    // Title
                    TitleComponent(name: title, color: .white, type: .largeTitle, weight: .bold) {
                        IconButton(title: ((numberOfColumns % 2) != 0)  ? "rectangle.grid.1x2.fill" : "square.grid.2x2.fill") {
                            withAnimation {
//                                numberOfColumns = numberOfColumns % 2 + 1
                            }
                        }
                    }
                    
                    // Cards
                    if let films = modelData.films[category] {
//                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(films) {
                                ListItem(film: $0, category: category, numberOfColumns: $numberOfColumns)
                            }
//                        }
                        
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
        .animation(.default)
    }
}

struct ListItem_Previews: PreviewProvider {
    static var previews: some View {
        ListView(title: "Now Playing", category: "movie/now_playing", searchText: .constant(""))
            .environmentObject(ModelData())
    }
}
