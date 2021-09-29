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
    @State var barHeights: [CGFloat]  = Array(repeating: 0, count: 7)
    
    var drag: some Gesture {
        DragGesture(minimumDistance: 0, coordinateSpace: .local)
            .onEnded({ value in
                // Left
                if value.translation.width < 0 && index < 0 {
                    index += 1
                }
                
                // Right
                if value.translation.width > 0 {
                    index -= 1
                }
            })
    }
    
    var body: some View {
        VStack {
            // Title
            HStack {
                Text("Screen Time (Movies)")
                    .font(.title3)
                    .fontWeight(.bold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                
                Spacer()
                
                Text(getTotalHoursPerWeek().convert())
                    .font(.caption)
                    .fontWeight(.semibold)
                    .opacity(0.5)
            }
            .foregroundColor(.white)
            .padding(.horizontal)
            
            VStack {
                if let startOfWeek = Date().getWeekInterval(weekOfYear: index).startOfWeek, let endOfWeek = Date().getWeekInterval(weekOfYear: index).endOfWeek {
                    AnotherChartTab(title: "\(startOfWeek.toString(format: "dd/MM/yy"))-\(endOfWeek.toString(format: "dd/MM/yy"))", selectedIndex: $index)
                        .gesture(drag)
                }
                
                // Bars
                ZStack(alignment: .center) {
                    GeometryReader { geometry in
                        let width = geometry.size.width / 2 * (1 / 7)
                        HStack(alignment: .center, spacing: geometry.size.width / 14.5) {
                            ForEach(Array(titles.enumerated()), id: \.offset) { id, title in
                                BarView(title: title, width: width, height: $barHeights[id])
                                    .onChange(of: index) { newValue in
                                        getBarHeights(index: id, title: title)
                                    }
                                    .onAppear {
                                        getBarHeights(index: id, title: title)
                                    }
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
        }
    }
    
    func getBarHeights(index: Int, title: String) {
        barHeights[index] = CGFloat(getTotalHoursPerDay(films[title]) / 60)
    }
    
    // Total Hours of Watching Films In A Week
    func getTotalHoursPerWeek() -> Int {
        var hours = 0
        films.forEach {
            hours += getTotalHoursPerDay($0.value)
        }
        
        return hours
    }
    
    // Total Hours of Watching Films In A Day
    func getTotalHoursPerDay(_ films: [Film]?) -> Int {
        return films?.compactMap { film -> Int in
            if let movie = film as? Movie {
                return film.addedDate.getWeek(index: index) ? (movie.runTime ?? 0) : 0
            } else if let tvShow = film as? TvShow {
                return film.addedDate.getWeek(index: index) ? (tvShow.runTime?.first ?? 0) : 0
            } else {
                return 0
            }
        }.reduce(0, +) ?? 0
    }
}
