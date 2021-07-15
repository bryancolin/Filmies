//
//  CategoryRow.swift
//  Filmies
//
//  Created by bryan colin on 7/10/21.
//

import SwiftUI

struct CategoryRow: View {
    
    @Binding var category: String
    @ObservedObject var modelData: ModelData
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top) {
                    ForEach(modelData.movies[category] ?? [Movie]()) { movie in
                        CategoryItem(movie: movie)
                    }
                }
            }
        }
    }
}
