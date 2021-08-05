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
    
    var body: some View {
        let columns = Array(repeating: GridItem(.flexible(), spacing: spacing), count: numberOfColumns)
        
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: columns, spacing: spacing) {
                if let films = modelData.films[category] {
                    ForEach(films) { film in
                        CardGridItem(film: film)
                            .redacted(reason: modelData.isLoading ? .placeholder : [])
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}
