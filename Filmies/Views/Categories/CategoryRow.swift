//
//  CategoryRow.swift
//  Filmies
//
//  Created by bryan colin on 7/10/21.
//

import SwiftUI

struct CategoryRow: View {
    
    @EnvironmentObject var modelData: ModelData
    
    var title: String
    var color: Color
    @Binding var category: String
    
    var body: some View {
        VStack(alignment: .leading) {
            // Title
            HStack {
                Text(title)
                    .foregroundColor(color)
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.leading, 15)
                
                Spacer()
                
                Button(action: {
                    
                }) {
                    Text("see all")
                        .foregroundColor(color)
                        .font(.caption)
                        .padding(.trailing)
                }
            }
            .padding(.top, 5)
            
            // Content
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    if let films = modelData.films[category] {
                        ForEach(films) { film in
                            CategoryItem(film: film, category: category)
                                .redacted(reason: modelData.isLoading ? .placeholder : [])
                        }
                    }
                }
            }
        }
    }
}
