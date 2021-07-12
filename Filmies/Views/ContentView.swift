//
//  ContentView.swift
//  Filmies
//
//  Created by bryan colin on 7/9/21.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .film
    
    enum Tab {
        case film
        case favorites
    }
    
    var body: some View {
//        TabView(selection: $selection) {
//            CategoryHome()
//                .tabItem {
//                    Label("Film", systemImage: "house.fill")
//                }
//                .tag(Tab.film)
//        }
        CategoryHome()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
