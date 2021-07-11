//
//  FilmCategory.swift
//  Filmies
//
//  Created by bryan colin on 7/9/21.
//

import SwiftUI
import UIKit

struct CategoryHome: View {
    
    @ObservedObject var modelData = ModelData()
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor(named: "BrandPink") ?? UIColor.black]
        
        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor: UIColor(named: "BrandPink") ?? UIColor.black]
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color("BrandBlue"), Color("BrandPurple")]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                ScrollView {
                    CategoryRow(categoryName: "Now Playing", movies: modelData.nowPlayingMovies)
                        .listRowInsets(EdgeInsets())
                    CategoryRow(categoryName: "Upcoming", movies: modelData.upcomingMovies)
                        .listRowInsets(EdgeInsets())
                }
                .navigationBarTitle("Film")
            }
        }
        .onAppear {
            modelData.fetchMovies("now_playing")
            modelData.fetchMovies("upcoming")
        }
    }
}

struct FilmCategory_Previews: PreviewProvider {
    static var previews: some View {
        CategoryHome()
    }
}
