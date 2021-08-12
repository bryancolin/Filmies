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
    
    @State private var isPresented = false
    
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
                    isPresented.toggle()
                }) {
                    Text("see all")
                        .foregroundColor(color)
                        .font(.subheadline)
                        .padding(.trailing)
                }
                .fullScreenCover(isPresented: $isPresented) {
                    ListItem(title: title, category: category)
                }
            }
            .padding(.top, 5)
            
            // Content
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    if let films = modelData.films[category] {
                        ForEach(0..<20) { index in
                            if index < films.count {
                                CategoryItem(film: films[index], category: category)
                                    .redacted(reason: modelData.isLoading ? .placeholder : [])
                            }
                        }
                    }
                }
            }
        }
    }
}
