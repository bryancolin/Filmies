//
//  AccountView.swift
//  Filmies
//
//  Created by bryan colin on 7/29/21.
//

import SwiftUI

struct AccountView: View {
    
    @EnvironmentObject var modelData: ModelData
    
    private var days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    @State private var totalHours = 0
    
    var body: some View {
        ZStack(alignment: .top) {
            Color(K.BrandColors.darkBlue)
                .ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(alignment: .leading) {
                    LargeTitle(name: "Account", color: .white, type: .largeTitle, weight: .bold) {}
                    
                    HStack {
                        Text("Movies Screen Time")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .font(.title3)
                        
                        Spacer()
                        Text("\(totalHours)m")
                            .foregroundColor(.white)
                            .font(.body)
                    }
                    .padding(.horizontal)
                    
                    if let movies = modelData.movies["favorites"] {
                        let hours = Dictionary(grouping: movies, by: { getDayOfWeek($0.addedAt) })
                        
                        ZStack(alignment: .center) {
                            GeometryReader { geometry in
                                let width = geometry.size.width / 2 * (1 / 7)
                                HStack(alignment: .center, spacing: geometry.size.width / 20) {
                                    ForEach(days, id: \.self) { day in
                                        let height = (hours[day]?.map({ $0.runTime ?? 0 }).reduce(0, +) ?? 0)
                                        BarView(day: day, width: width, height: CGFloat(height / 60))
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
    
    var day: String
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
            
            Text(day.prefix(1))
                .foregroundColor(.white)
        }
    }
}
