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
    
    @State var selectedType = "movie"
    @State var selectedIndex1 = 0
    @State var selectedIndex2 = 0
    
    init() {
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color(K.BrandColors.pink))], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
    }
    
    var body: some View {
        ZStack {
            // Glassmorphism Background
            GlassmorphismBackground(type: .left, circleColors: .constant([Color(K.BrandColors.purple), Color(K.BrandColors.pink), Color(K.BrandColors.blue)]), backgroundColors: [Color(K.BrandColors.blue), Color(K.BrandColors.purple)])
            
            ScrollView(.vertical, showsIndicators: false) {
                // Title
                GeometryReader { geometry in
                    TitleComponent(name: "Trending", color: Color(K.BrandColors.pink), type: .largeTitle, weight: .bold) {
                        Picker(selection: $selectedType, label: Text("")) {
                            Text("M").tag("movie")
                            Text("T").tag("tv")
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(width: geometry.size.width * 0.2)
                    }
                }
                .frame(height: 75)
                
                // Scroll Tab for Trending Movies (Day & Week)
                ScrollTabView(titles: ["Today", "This Week"], selectedIndex: $selectedIndex1)
                CardView(category: selectedType == "movie" ? $modelData.movieParams[selectedIndex1] : $modelData.tvShowParams[selectedIndex1])
                
                // Scroll Tab for Now Showing Movies
                let titles = selectedType == "movie" ? ["Now Playing", "Popular", "Upcoming"] : ["Airing Today", "Popular", "On The Air"]
                ScrollTabView(titles: titles, selectedIndex: $selectedIndex2)
                CategoryRow(category: selectedType == "movie" ? $modelData.movieParams[selectedIndex2+2] : $modelData.tvShowParams[selectedIndex2+2])
                
                // Scroll Tab for Top Rated Movies
                ScrollTabView(titles: ["Top Rated"], selectedIndex: .constant(0))
                CategoryRow(category: selectedType == "movie" ? $modelData.movieParams[modelData.movieParams.count-1] : $modelData.tvShowParams[modelData.tvShowParams.count-1])
            }
        }
        .onAppear {
            if modelData.films.isEmpty {
                modelData.fetchFilms()
                modelData.loadFavoriteMovies()
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

