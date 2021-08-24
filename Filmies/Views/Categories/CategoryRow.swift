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
    var category: String
    
    @State private var isPresented = false
    
    var body: some View {
        VStack(alignment: .leading) {
            // Title
            HStack {
                Text(title)
                    .foregroundColor(color)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.leading, 15)
                
                Spacer()
                
                Button(action: {
                    isPresented.toggle()
                }) {
                    Text("see all")
                        .foregroundColor(Color.white.opacity(0.5))
                        .font(.caption)
                        .fontWeight(.semibold)
                        .padding(.trailing)
                }
                .fullScreenCover(isPresented: $isPresented) {
                    ListView(title: title, category: category, searchText: .constant(""))
                        .environmentObject(modelData)
                        .animation(.default)
                }
            }
            .padding(.top, 5)
            
            // Content
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    if let films = modelData.films[category] {
                        ForEach(0..<20) {
                            if $0 < films.count {
                                CategoryItem(film: films[$0], category: category)
                                    .redacted(reason: modelData.isLoading ? .placeholder : [])
                                    .padding(.trailing, $0 == 19 ? 15 : 0)
                            }
                        }
                    }
                }
            }
        }
    }
}
