//
//  ChartView.swift
//  Filmies
//
//  Created by bryan colin on 7/30/21.
//

import SwiftUI

struct ChartView: View {
    
    var films: [String: [Film]]
    var titles: [String]
    
    @State var index = 0
    
    var body: some View {
        VStack {
            // Title
            HStack {
                Text("Screen Time (Movies)")
                    .foregroundColor(.white)
                    .font(.title3)
                    .fontWeight(.bold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                
                Spacer()
                
                Text(getTotalHoursPerWeek().convert())
                    .foregroundColor(.white)
                    .font(.caption)
            }
            .padding(.horizontal)
            
            VStack {
                ChartTab(titles: ["This Week", "Last Week"], selectedIndex: $index)
                
                // Bars
                ZStack(alignment: .center) {
                    GeometryReader { geometry in
                        let width = geometry.size.width / 2 * (1 / 7)
                        HStack(alignment: .center, spacing: geometry.size.width / 14.5) {
                            ForEach(titles, id: \.self) { title in
                                let height = (CGFloat(getTotalHoursPerDay(films[title]).thisWeek / 60), CGFloat(getTotalHoursPerDay(films[title]).lastWeek / 60))
                                BarView(title: title, width: width, height: height, index: $index)
                            }
                        }
                        .padding(.horizontal)
                    }
                    .frame(height: 250)
                }
            }
            .background(Blur(style: .dark))
            .cornerRadius(15)
            .padding(.horizontal, 10)
            .padding(.vertical)
        }
    }
    
    // Total Hours of Watching Films In A Week
    func getTotalHoursPerWeek() -> Int {
        var hours = 0
        for (_, allFilms) in films {
            hours += index == 0 ? getTotalHoursPerDay(allFilms).thisWeek : getTotalHoursPerDay(allFilms).lastWeek
        }
        
        return hours
    }
    
    // Total Hours of Watching Films In A Day
    func getTotalHoursPerDay(_ films: [Film]?) -> (thisWeek: Int, lastWeek: Int) {
        return (
            films?.compactMap { film -> Int in
                if let movie = film as? Movie {
                    return film.addedDate.isThisWeek() ? (movie.runTime ?? 0) : 0
                } else if let tvShow = film as? TvShow {
                    return film.addedDate.isThisWeek() ? (tvShow.runTime?.first ?? 0) : 0
                } else {
                    return 0
                }
            }.reduce(0, +) ?? 0,
            
            films?.compactMap { film -> Int in
                if let movie = film as? Movie {
                    return film.addedDate.isLastWeek() ? (movie.runTime ?? 0) : 0
                } else if let tvShow = film as? TvShow {
                    return film.addedDate.isLastWeek() ? (tvShow.runTime?.first ?? 0) : 0
                } else {
                    return 0
                }
            }.reduce(0, +) ?? 0
        )
    }
}
