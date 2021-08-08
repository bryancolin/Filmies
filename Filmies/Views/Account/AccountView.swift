//
//  AccountView.swift
//  Filmies
//
//  Created by bryan colin on 7/29/21.
//

import SwiftUI

struct AccountView: View {
    
    @EnvironmentObject var modelData: ModelData
    @State var colors = [Color(K.BrandColors.blue), Color(K.BrandColors.pink), Color(K.BrandColors.purple)]
    
    var body: some View {
        ZStack(alignment: .top) {
            // Glassmorphism Background
            GlassmorphismBackground(type: .left, circleColors: $colors, backgroundColors: [Color(K.BrandColors.purple), Color(K.BrandColors.blue)])
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                    GeometryReader { geometry in
                        TitleComponent(name: "Account", color: .white, type: .largeTitle, weight: .bold) {
                            HStack(alignment: .center) {
                                ForEach(0..<colors.count) { index in
                                    Button(action: {
                                        colors.rotateLeft(positions: index)
                                    }) {
                                        Circle()
                                            .foregroundColor(colors[index])
                                            .animation(.spring())
                                    }
                                }
                            }
                            .frame(width: geometry.size.width * 0.25)
                        }
                    }
                    .frame(height: 75)

                    if let movies = modelData.films[K.MovieCategory.favorites] as? [Movie] {
                        let categorizeMovies = Dictionary(grouping: movies, by: { $0.addedDate.fullDayName() })
                        ChartView(films: categorizeMovies, titles: ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"])
                    }
                    
                    // Scroll Tab for Favorites Movies
                    ScrollTabView(titles: ["Favorites Movies"], selectedIndex: .constant(0))
                    CategoryRow(category: .constant(K.MovieCategory.favorites))
                    
                    // Scroll Tab for Favorites TvShows
                    ScrollTabView(titles: ["Favorites TV Shows"], selectedIndex: .constant(0))
                    CategoryRow(category: .constant(K.TvShowCategory.favorites))
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
