//
//  ChartView.swift
//  Filmies
//
//  Created by bryan colin on 7/30/21.
//

import SwiftUI

struct ChartView: View {
    
    @EnvironmentObject var modelData: ModelData
    var movies: [String: [Movie]]
    var titles: [String]
    
    var body: some View {
        VStack {
            // Title
            HStack {
                ScrollTabView(titles: ["Screen Time (Movies)"], selectedIndex: .constant(0))
                
                Spacer()
                
                Text(getTotalHoursPerWeek().convert())
                    .foregroundColor(.white)
                    .font(.body)
            }
            .padding(.bottom)
            .padding(.trailing)
            
            // Bars
            ZStack(alignment: .center) {
                GeometryReader { geometry in
                    let width = geometry.size.width / 2 * (1 / 7)
                    HStack(alignment: .center, spacing: geometry.size.width / 14.5) {
                        ForEach(titles, id: \.self) { title in
                            let height = getTotalHoursPerDay(movies[title])
                            BarView(title: title, width: width, height: CGFloat(height / 60))
                        }
                    }
                    .padding(.horizontal)
                }
                .frame(height: 250)
            }
        }
    }
    
    // Total Hours of Watching Movies In A Week
    func getTotalHoursPerWeek() -> Int {
        var hours = 0
        for (_, allMovies) in movies {
            hours += getTotalHoursPerDay(allMovies)
        }
        
        return hours
    }
    
    // Total Hours of Watching Movies In A Day
    func getTotalHoursPerDay(_ movies: [Movie]?) -> Int {
        return movies?.compactMap { movie -> Int in
            return movie.addedDate.isThisWeek() ? movie.runTime ?? 0 : 0
        }.reduce(0, +) ?? 0
    }
}
