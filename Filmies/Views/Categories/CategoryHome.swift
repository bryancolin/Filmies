//
//  FilmCategory.swift
//  Filmies
//
//  Created by bryan colin on 7/9/21.
//

import SwiftUI
import UIKit

struct CategoryHome: View {
    
    @StateObject var modelData = ModelData()
    
    @State var selectedIndex1 = 0
    @State var selectedIndex2 = 0
    @State var selectedIndex3 = 0
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            // Title
            VStack(spacing: nil) {
                HStack {
                    Text("Trending")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color("BrandPink"))
                    
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.vertical)
            }
            
            // Scroll Tab for Trending Movies (Day & Week)
            ScrollTab(titles: ["Day", "Week"], index: $selectedIndex1)
            CardView(category: $modelData.params[selectedIndex1], modelData: modelData)
            
            // Scroll Tab for Now Showing Movies
            ScrollTab(titles: ["Now Playing", "Popular", "Upcoming"], index: $selectedIndex2)
            CategoryRow(category: $modelData.params[selectedIndex2+2], modelData: modelData)
            
            // Scroll Tab for Top Rated Movies
            ScrollTab(titles: ["Top Rated"], index: $selectedIndex3)
            CategoryRow(category: $modelData.params[modelData.params.count-1], modelData: modelData)
            
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [Color("BrandBlue"), Color("BrandPurple")]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
        )
        .onAppear {
            modelData.fetchMovies()
        }
    }
}

struct FilmCategory_Previews: PreviewProvider {
    static var previews: some View {
        CategoryHome()
    }
}

struct ScrollTab: View {
    
    var titles: [String]
    @Binding var index: Int
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                RoundedText(titles: titles, index: $index)
            }
            .padding(.horizontal)
        }
    }
}

struct RoundedText: View {
    
    var titles: [String]
    @Binding var index: Int
    
    var body: some View {
        ForEach(0..<titles.count) { value in
            Text(titles[value])
                .font(.system(size: 15))
                .fontWeight(.bold)
                .padding(.vertical, 6)
                .padding(.horizontal, 20)
                .foregroundColor(value == index ? .white : Color("BrandPink"))
                .background(Color("BrandPink").opacity(value == index ? 1 : 0))
                .clipShape(Capsule())
                .onTapGesture {
                    if index < titles.count {
                        index = value
                    }
                }
        }
    }
}

