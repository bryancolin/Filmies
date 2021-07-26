//
//  CategoryRow.swift
//  Filmies
//
//  Created by bryan colin on 7/10/21.
//

import SwiftUI

struct CategoryRow: View {
    
    @EnvironmentObject var modelData: ModelData
    
    @Binding var category: String
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top) {
                    if let movies = modelData.movies[category] {
                        ForEach(movies) { movie in
                            CategoryItem(movie: movie, category: category)
                                .redacted(reason: modelData.isLoading ? .placeholder : [])
                        }
                    }
                }
            }
        }
    }
}
