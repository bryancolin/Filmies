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
                    .animation(.default)
            case .search:
                SearchView()
            case .person:
                AccountView()
                    .animation(.default)
            }
        }
        .overlay(
            CustomTabBar(selectedTab: $selectedTab)
                .padding(.bottom, getSafeArea().bottom == 0 ? 12 : 0),
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
