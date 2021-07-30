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
    
    var gradient: LinearGradient {
        LinearGradient (
            gradient: Gradient(colors: [Color(K.BrandColors.blue), Color(K.BrandColors.purple)]),
            startPoint: .top,
            endPoint: .bottom
        )
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            // Title
            VStack(spacing: nil) {
                LargeTitle(name: "Trending", color: Color(K.BrandColors.pink), type: .largeTitle, weight: .bold) {}
            }
            
            // Scroll Tab for Trending Movies (Day & Week)
            ScrollTabView(titles: ["Today", "This Week"], index: $selectedIndex1)
            CardView(category: $modelData.params[selectedIndex1])
            
            // Scroll Tab for Now Showing Movies
            ScrollTabView(titles: ["Now Playing", "Popular", "Upcoming"], index: $selectedIndex2)
            CategoryRow(category: $modelData.params[selectedIndex2+2])
            
            // Scroll Tab for Top Rated Movies
            ScrollTabView(titles: ["Top Rated"], index: .constant(0))
            CategoryRow(category: $modelData.params[modelData.params.count-1])
            
            // Scroll Tab for Top Rated Movies
            ScrollTabView(titles: ["Favorites"], index: .constant(0))
            CategoryRow(category: .constant("favorites"))
        }
        .background(
            gradient
                .ignoresSafeArea()
        )
        .onAppear {
            if modelData.movies.isEmpty {
                modelData.fetchMovies()
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

