//
//  ChartView.swift
//  Filmies
//
//  Created by bryan colin on 7/30/21.
//

import SwiftUI

struct ChartView: View {
    
    var movies: [String: [Movie]]
    var titles: [String]
    
    @State var index = 0
    
    var body: some View {
        VStack {
            // Title
            HStack {
                ScrollTabView(titles: ["Screen Time (Movies)"], selectedIndex: .constant(0))
                
                Spacer()
                
                Text(getTotalHoursPerWeek().convert())
                    .foregroundColor(.white)
                    .font(.body)
                    .padding(.trailing)
            }
            
            Picker(selection: $index, label: Text("")) {
                Text("This Week").tag(0)
                Text("Last Week").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            // Bars
            ZStack(alignment: .center) {
                GeometryReader { geometry in
                    let width = geometry.size.width / 2 * (1 / 7)
                    HStack(alignment: .center, spacing: geometry.size.width / 14.5) {
                        ForEach(titles, id: \.self) { title in
                            let height = (CGFloat(getTotalHoursPerDay(movies[title]).thisWeek / 60), CGFloat(getTotalHoursPerDay(movies[title]).lastWeek / 60))
                            BarView(title: title, width: width, height: height, index: $index)
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
            hours += index == 0 ? getTotalHoursPerDay(allMovies).thisWeek : getTotalHoursPerDay(allMovies).lastWeek
        }
        
        return hours
    }
    
    // Total Hours of Watching Movies In A Day
    func getTotalHoursPerDay(_ movies: [Movie]?) -> (thisWeek: Int, lastWeek: Int) {
        return (
            movies?.compactMap { movie -> Int in return movie.addedDate.isThisWeek() ? movie.runTime ?? 0 : 0 }.reduce(0, +) ?? 0,
            movies?.compactMap { movie -> Int in return movie.addedDate.isLastWeek() ? movie.runTime ?? 0 : 0 }.reduce(0, +) ?? 0
        )
    }
}
