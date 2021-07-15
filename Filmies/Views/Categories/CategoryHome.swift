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
    @State var selectedIndex = 0
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: nil) {
                // Title
                HStack {
                    Text("Trending")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(Color("BrandPink"))
                    
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.vertical)
            }
            
            // Card View
            CardView(category: modelData.params[selectedIndex], modelData: modelData)
            
            // Option
            ScrollTab(titles: modelData.params, index: selectedIndex)
            
            CategoryRow(categoryName:  modelData.params[selectedIndex], movies: modelData.movies[modelData.params[selectedIndex]] ?? [Movie]())
                                    .listRowInsets(EdgeInsets())
            
//            ForEach(modelData.params, id: \.self) { value in
//                CategoryRow(categoryName: value, movies: modelData.movies[value] ?? [Movie]())
//                                        .listRowInsets(EdgeInsets())
//            }
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
    @State var index: Int
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                RoundedText(titles: titles, index: index)
            }
            .padding(.horizontal)
        }
    }
}

struct RoundedText: View {
    
    var titles: [String]
    @State var index: Int
    
    var body: some View {
        
        ForEach(0..<titles.count) { value in
            Text(titles[value])
                .font(.system(size: 15))
                .fontWeight(.bold)
                .padding(.vertical, 6)
                .padding(.horizontal, 20)
                .foregroundColor(value == index ? .white : .black)
                .background(Color.blue.opacity(value == index ? 1 : 0))
                .clipShape(Capsule())
                .onTapGesture {
                    index = value
                }
        }
    }
}

