//
//  ContentView.swift
//  Filmies
//
//  Created by bryan colin on 7/9/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var selectedTab: Tab = .house
        
    var body: some View {
        ZStack {
            switch selectedTab {
            case .house:
                CategoryHome()
            case .star:
                FavoritesView()
            case .search:
                SearchView()
            default:
                Color.white
            }
        }
        .overlay(
            CustomTabBar(selectedTab: $selectedTab)
                .padding(.vertical),
            alignment: .bottom
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
