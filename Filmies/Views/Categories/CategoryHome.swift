//
//  FilmCategory.swift
//  Filmies
//
//  Created by bryan colin on 7/9/21.
//

import SwiftUI
import UIKit

struct CategoryHome: View {
    
    @EnvironmentObject var modelData: ModelData
    
    @State var selectedIndex1 = 0
    @State var selectedIndex2 = 0
    
    var body: some View {
        ZStack {
            // Glassmorphism Background
            GlassmorphismBackground(type: .left, circleColors: .constant([Color(K.BrandColors.purple), Color(K.BrandColors.pink), Color(K.BrandColors.blue)]), backgroundColors: [Color(K.BrandColors.blue), Color(K.BrandColors.purple)])
            
            ScrollView(.vertical, showsIndicators: false) {
                // Title
                GeometryReader { geometry in
                    TitleComponent(name: "Trending", color: Color(K.BrandColors.pink), type: .largeTitle, weight: .bold) {                        
                        CustomPicker(width: geometry.size.width * 0.2)
                    }
                }
                .frame(height: 75)
                
                // Scroll Tab for Trending Movies (Day & Week)
                ScrollTabView(titles: ["Today", "This Week"], selectedIndex: $selectedIndex1)
                CardView(category: modelData.selectedType == .movie ? $modelData.movieParams[selectedIndex1] : $modelData.tvShowParams[selectedIndex1])
                
                // Scroll Tab for Now Showing Movies
                let titles = modelData.selectedType == .movie ? ["Now Playing", "Popular", "Upcoming"] : ["Airing Today", "Popular", "On The Air"]
                ScrollTabView(titles: titles, selectedIndex: $selectedIndex2)
                CategoryRow(category: modelData.selectedType == .movie ? $modelData.movieParams[selectedIndex2+2] : $modelData.tvShowParams[selectedIndex2+2])
                
                // Scroll Tab for Top Rated Movies
                ScrollTabView(titles: ["Top Rated"], selectedIndex: .constant(0))
                CategoryRow(category: modelData.selectedType == .movie ? $modelData.movieParams[modelData.movieParams.count-1] : $modelData.tvShowParams[modelData.tvShowParams.count-1])
            }
        }
    }
}

struct FilmCategory_Previews: PreviewProvider {
    static var previews: some View {
        CategoryHome()
            .environmentObject(ModelData())
    }
}

