//
//  CardGrid.swift
//  Filmies
//
//  Created by bryan colin on 7/22/21.
//

import SwiftUI

struct CardGrid: View {
    
    @EnvironmentObject var modelData: ModelData
    
    let spacing: CGFloat = 10
    @Binding var numberOfColumns: Int
    
    var body: some View {
        let columns = Array(repeating: GridItem(.flexible(), spacing: spacing), count: numberOfColumns)
        
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: columns, spacing: spacing) {
                if let movies = modelData.movies["search"] {
                    ForEach(movies) { movie in
                        CardGridItem(movie: movie)
                            .redacted(reason: modelData.isLoading ? .placeholder : [])
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}
