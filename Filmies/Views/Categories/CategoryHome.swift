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
    
    @State var selectedIndex = 0
    
    var background: some View {
        GlassmorphismBackground(type: .left, circleColors: .constant([Color(K.BrandColors.purple), Color(K.BrandColors.pink), Color(K.BrandColors.blue)]), backgroundColors: [Color(K.BrandColors.blue), Color(K.BrandColors.purple)])
    }
    
    var title: some View {
        GeometryReader { geometry in
            TitleComponent(name: "Trending", color: Color(K.BrandColors.pink), type: .largeTitle, weight: .semibold) {
                CustomPicker(width: geometry.size.width * 0.2)
            }
        }
        .frame(height: 75)
    }
    
    var body: some View {
        ZStack {
            // Glassmorphism Background
            background
            
            ScrollView(showsIndicators: false) {
                // Title
                title
                
                // Scroll Tab for Trending Movies (Day & Week)
                ScrollTabView(titles: ["Today", "This Week"], selectedIndex: $selectedIndex)
                CardView(category: modelData.selectedType == .movie ? $modelData.movieParams[selectedIndex] : $modelData.tvShowParams[selectedIndex])
                
                // Scroll View
                let subtitles = modelData.selectedType == .movie ? ["Now Playing", "Popular", "Upcoming", "Top Rated"] : ["Airing Today", "Popular", "On The Air", "Top Rated"]
                
                ForEach(0..<subtitles.count) {
                    CategoryRow(title: subtitles[$0], color: Color(K.BrandColors.pink), category: modelData.selectedType == .movie ? $modelData.movieParams[$0 + 2] : $modelData.tvShowParams[$0 + 2])
                }
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

