//
//  ChartView.swift
//  Filmies
//
//  Created by bryan colin on 7/30/21.
//

import SwiftUI

struct ChartView: View {
    
    @EnvironmentObject var modelData: ModelData
    
    private var days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    var body: some View {
        VStack {
            if let favoriteMovies = modelData.movies[K.MovieCategory.favorites] {
                
                let totalHours = favoriteMovies.map { movie -> Int in
                    return movie.addedDate.isThisWeek() ? movie.runTime ?? 0 : 0
                }.reduce(0, +)
                
                HStack {
                    ScrollTabView(titles: ["Screen Time"], selectedIndex: .constant(0))
                    
                    Spacer()
                    
                    Text(totalHours.convert())
                        .foregroundColor(.white)
                        .font(.body)
                }
                .padding(.trailing)
                
                let movies = Dictionary(grouping: favoriteMovies, by: { $0.addedDate.fullDayName() })
                
                ZStack(alignment: .center) {
                    GeometryReader { geometry in
                        let width = geometry.size.width / 2 * (1 / 7)
                        HStack(alignment: .center, spacing: geometry.size.width / 14.5) {
                            ForEach(days, id: \.self) { day in
                                
                                let height = movies[day]?.map { movie -> Int in
                                    return movie.addedDate.isThisWeek() ? movie.runTime ?? 0 : 0
                                }.reduce(0, +) ?? 0
                                
                                BarView(title: day, width: width, height: CGFloat(height / 60))
                            }
                        }
                        .padding(.horizontal)
                    }
                    .frame(height: 250)
                }
            }
        }
    }
}
