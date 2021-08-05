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
                                ForEach(Array(colors.enumerated()), id: \.offset) { index, color in
                                    Button(action: {
                                        colors.rotateLeft(positions: index)
                                    }) {
                                        Circle()
                                            .foregroundColor(color)
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
