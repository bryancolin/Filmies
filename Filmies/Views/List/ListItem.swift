//
//  ListItem.swift
//  Filmies
//
//  Created by bryan colin on 8/12/21.
//

import SwiftUI

struct ListItem: View {
    
    @EnvironmentObject var modelData: ModelData
    @Environment(\.presentationMode) var presentationMode
    
    var title: String
    var category: String
    
    var background: some View {
        GlassmorphismBackground(type: .left, circleColors: .constant([Color(K.BrandColors.purple), Color(K.BrandColors.pink), Color(K.BrandColors.blue)]), backgroundColors: [Color.black], blurRadius: 100)
    }
    
    var body: some View {
        ZStack {
            // Background
            background
            // Component
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                    // Back Button
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.backward")
                            .font(.system(size: 25, weight: .semibold))
                    }
                    .padding()
                    
                    // Title
                    TitleComponent(name: title, color: .white, type: .largeTitle, weight: .bold, firstContent: {}, secondContent: {})
                    
                    // Cards
                    if let films = modelData.films[category] {
                        ForEach(films) { film in
                            HStack(alignment: .top) {
                                CategoryItem(film: film, category: category, width: UIScreen.main.bounds.width / 2)
                                
                                VStack(alignment: .leading) {
                                    Text(film.title ?? "")
                                        .font(.title3)
                                        .fontWeight(.bold)
                                        .padding(.bottom, 5)
                                    
                                    Text(film.description ?? "")
                                }
                                .padding(.horizontal)
                            }
                            .frame(height: UIScreen.main.bounds.height / 3)
                            .padding(.vertical)
                            .redacted(reason: modelData.isLoading ? .placeholder : [])
                        }
                    }
                }
            }
            .foregroundColor(.white)
        }
    }
}

struct ListItem_Previews: PreviewProvider {
    static var previews: some View {
        ListItem(title: "Now Playing", category: "movie/now_playing")
            .environmentObject(ModelData())
    }
}
