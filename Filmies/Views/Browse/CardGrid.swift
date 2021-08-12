//
//  CardGrid.swift
//  Filmies
//
//  Created by bryan colin on 7/22/21.
//

import SwiftUI

struct CardGrid: View {
    
    @EnvironmentObject var modelData: ModelData
    var category: String
    
    let spacing: CGFloat = 10
    @Binding var numberOfColumns: Int
    @Binding var searchText: String
    
    var body: some View {
        let columns = Array(repeating: GridItem(.flexible(), spacing: spacing), count: numberOfColumns)
        
        ScrollView(.vertical, showsIndicators: false) {
            if let films = modelData.films[category] {
                LazyVGrid(columns: columns, spacing: spacing) {
                    ForEach(films) { film in
                        CardGridItem(film: film)
                            .redacted(reason: modelData.isLoading ? .placeholder : [])
                    }
                }
                .padding(.horizontal)
                
                if films.count % 20 == 0 {
                    Button(action: {
                        modelData.fetchFilms(with: category, name: searchText, pageNumber: (films.count / 20) + 1)
                    }) {
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundColor(.white)
                            .frame(height: 50)
                            .overlay(
                                Text("Load more")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(K.BrandColors.pink))
                            )
                    }
                    .padding()
                    .padding(.bottom, 60)
                }
            }
        }
    }
}
