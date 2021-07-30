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
                    LargeTitle(name: "Account", color: .white, type: .largeTitle, weight: .bold) {}
                    
                    ChartView()
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

struct ChartView: View {
    
    @EnvironmentObject var modelData: ModelData
    
    private var days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    var body: some View {
        VStack {
            if let favoriteMovies = modelData.movies["favorites"] {
                let time = favoriteMovies.map({ $0.runTime ?? 0 }).reduce(0, +)
                
                HStack {
                    Text("Screen Time")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .font(.title3)
                    
                    Spacer()
                    Text(getTotalHours(from: time))
                        .foregroundColor(.white)
                        .font(.body)
                }
                .padding(.horizontal)
                
                let movies = Dictionary(grouping: favoriteMovies, by: { getDayOfWeek($0.addedAt ?? 0) })
                
                ZStack(alignment: .center) {
                    GeometryReader { geometry in
                        let width = geometry.size.width / 2 * (1 / 7)
                        HStack(alignment: .center, spacing: geometry.size.width / 14.5) {
                            ForEach(days, id: \.self) { day in
                                let height = (movies[day]?.map({ $0.runTime ?? 0 }).reduce(0, +) ?? 0)
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
    
    func getTotalHours(from time: Int) -> String {
        if let movies = modelData.movies["favorites"] {
            let addedAtt = movies.map{  NSDate(timeIntervalSince1970: $0.addedAt ?? 0) as Date }
            print(addedAtt)
        }
        let hours = time / 60
        let minutes = time % 60
        return String(hours > 0 ? "\(hours)h " : "") + String(minutes != 0 ? "\(minutes)m" : "")
    }
    
    func getDayOfWeek(_ unixDate: Double) -> String? {
        let date = NSDate(timeIntervalSince1970: unixDate) as Date
        let dateFormatter  = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayOfTheWeekString = dateFormatter.string(from: date)
        return dayOfTheWeekString
    }
}

struct BarView: View {
    
    var title: String
    var width: CGFloat
    var height: CGFloat
    
    @State private var progress: CGFloat = 0
    @State private var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 200)
                    .foregroundColor(Color.white.opacity(0.1))
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: progress)
                    .foregroundColor(Color(K.BrandColors.pink))
                    .animation(.linear)
                    .onReceive(timer, perform: { _ in
                        if progress < (height/6*200) {
                            progress += 10
                        }
                    })
            }
            .frame(width: width)
            
            Text(title.prefix(1))
                .foregroundColor(.white)
        }
    }
}
