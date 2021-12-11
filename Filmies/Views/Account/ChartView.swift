//
//  ChartView.swift
//  Filmies
//
//  Created by bryan colin on 7/30/21.
//

import SwiftUI

struct ChartView: View {
    
    //MARK: - PROPERTIES
    
    var films: [String: [Film]]
    var titles: [String]
    
    @State var index = 0
    @State var barHeights: [CGFloat]  = Array(repeating: 0, count: 7)
    
    var drag: some Gesture {
        DragGesture(minimumDistance: 0, coordinateSpace: .local)
            .onEnded({ value in
                // Left
                if value.translation.width < 0 && index < 0 {
                    withAnimation {
                        index += 1
                    }
                }
                
                // Right
                if value.translation.width > 0 {
                    withAnimation {
                        index -= 1
                    }
                }
            })
    }
    
    //MARK: - BODY
    
    var body: some View {
        VStack {
            // TITLE
            HStack {
                Text("Screen Time (Movies)")
                    .font(.title2)
                    .fontWeight(.bold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                
                Spacer()
                
                Text(getTotalHoursPerWeek().toTimeString())
                    .fontWeight(.semibold)
                    .opacity(0.5)
            } //: HSTACK
            .foregroundColor(.white)
            .padding(.horizontal)
            
            // CONTENT
            VStack {
                if let week = Date().getWeekInterval(weekOfYear: index), let startOfWeek = week.startOfWeek, let endOfWeek = week.endOfWeek {
                    ChartTab(title: "\(startOfWeek.toString(format: "dd/MM/yy"))-\(endOfWeek.toString(format: "dd/MM/yy"))", selectedIndex: $index)
                        .gesture(drag)
                }
                
                // BARS
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
                            } //: LOOP
                        } //: HSTACK
                        .padding(.horizontal)
                    } //: GEOMETRYREADER
                    .frame(height: 250)
                } //: ZSTACK
            } //: VSTACK
            .background(Blur(style: .dark))
            .cornerRadius(15)
            .padding(.horizontal, 10)
        } //: VSTACK
    }
    
    //MARK: - FUNCTIONS
    
    func getBarHeights(index: Int, title: String) {
        barHeights[index] = CGFloat(getTotalHoursPerDay(films[title]) / 60)
    }
    
    // TOTAL HOURS OF WATCHING FILMS IN A WEEK
    func getTotalHoursPerWeek() -> Int {        
        return films.map { getTotalHoursPerDay($0.value) }.reduce(0, +)
    }
    
    // TOTAL HOURS OF WATCHING FILMS IN A DAY
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

//MARK: - PREVIEW

struct ChartView_Previews: PreviewProvider {
    static let categorizeMovies = Dictionary(grouping: Film.getPlaceholderData(), by: { $0.addedDate.toString(format: K.DateFormat.day) })
    
    static var previews: some View {
        ChartView(films: categorizeMovies, titles: ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"])
            .environmentObject(ModelData())
    }
}

