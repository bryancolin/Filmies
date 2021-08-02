//
//  AccountView.swift
//  Filmies
//
//  Created by bryan colin on 7/29/21.
//

import SwiftUI

struct AccountView: View {
    
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        ZStack(alignment: .top) {
            Color(K.BrandColors.darkBlue)
                .ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(alignment: .leading) {
                    TitleComponent(name: "Account", color: .white, type: .largeTitle, weight: .bold) {}
                    
                    if let movies = modelData.movies[K.MovieCategory.favorites] {
                        let categorizeMovies = Dictionary(grouping: movies, by: { $0.addedDate.fullDayName() })
                        ChartView(movies: categorizeMovies, titles: ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"])
                    }
                    
                    // Scroll Tab for Favorites Movies
                    ScrollTabView(titles: ["Favorites"], selectedIndex: .constant(0))
                    CategoryRow(category: .constant(K.MovieCategory.favorites))
                }
            }
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
            .environmentObject(ModelData())
    }
}
