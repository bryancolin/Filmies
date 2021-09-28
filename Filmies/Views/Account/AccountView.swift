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
    
    var background: some View {
        GlassmorphismBackground(type: .left, circleColors: $colors, backgroundColors: [Color(K.BrandColors.purple), Color(K.BrandColors.blue)])
    }
    
    var title: some View {
        GeometryReader { geometry in
            TitleComponent(name: "Account", color: .white, type: .largeTitle, weight: .semibold) {
                HStack(alignment: .center) {
                    ForEach(0..<colors.count) { index in
                        Button(action: {
                            colors.rotateLeft(positions: index)
                        }) {
                            Circle()
                                .foregroundColor(colors[index])
                        }
                    }
                }
                .frame(width: geometry.size.width * 0.25)
            }
        }
        .frame(height: 75)
    }
    
    var body: some View {
        // Glassmorphism Background
        background
        
        ScrollView(showsIndicators: false) {
            // Title
            title
            
            if let movies = modelData.films[K.Movie.favorites] as? [Movie] {
                let categorizeMovies = Dictionary(grouping: movies, by: { $0.addedDate.fullDayName() })
                ChartView(films: categorizeMovies, titles: ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"])
            }
            
            CategoryRow(title: "Favorite Movies", color: .white, category: K.Movie.favorites)
            CategoryRow(title: "Favorite TV Shows", color: .white, category: K.Tv.favorites)
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
            .environmentObject(ModelData())
    }
}
