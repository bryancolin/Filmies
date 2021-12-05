//
//  CategoryRow.swift
//  Filmies
//
//  Created by bryan colin on 7/10/21.
//

import SwiftUI

struct CategoryRow: View {
    
    //MARK: - PROPERTIES
    
    @EnvironmentObject var modelData: ModelData
    
    var title: String
    var color: Color
    var category: String
    
    @State private var isPresented = false
    
    //MARK: - BODY
    
    var body: some View {
        VStack(alignment: .leading) {
            if let films = modelData.films[category], !films.isEmpty {
                // TITLE
                TitleComponent(name: title, color: color, type: .title2, weight: .black) {
                    Button(action: {
                        isPresented.toggle()
                    }) {
                        Text("see all")
                            .foregroundColor(Color.white.opacity(0.5))
                            .fontWeight(.semibold)
                    }
                    .fullScreenCover(isPresented: $isPresented) {
                        ListView(title: title, category: category, searchText: .constant(""))
                            .environmentObject(modelData)
                    }
                } //: TITLE
                .padding(.vertical, -10)
                
                // CONTENT
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top, spacing: 0) {
                        ForEach(0..<20) {
                            if $0 < films.count {
                                CategoryItem(film: films[$0], category: category)
                                    .redacted(reason: modelData.isLoading ? .placeholder : [])
                                    .padding(.trailing, $0 == 19 ? 15 : 0)
                            }
                        } //: LOOP
                    } //: HSTACK
                } //: SCROLL
            }
        } //: VSTACK
    }
}

//MARK: - PREVIEW

struct CategoryRow_Previews: PreviewProvider {
    static var previews: some View {
        CategoryRow(title: "Now Playing", color: .pink, category: "movie/now_playing")
            .previewLayout(.sizeThatFits)
            .padding()
            .environmentObject(ModelData())
    }
}
