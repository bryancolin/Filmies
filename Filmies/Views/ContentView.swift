//
//  ContentView.swift
//  Filmies
//
//  Created by bryan colin on 7/9/21.
//

import SwiftUI

struct ContentView: View {
    
    //MARK: - PROPERTIES
    
    @State private var selectedTab: Tab = .house
    @State private var isAnimating: Bool = false
    
    //MARK: - BDOY
    
    var body: some View {
        ZStack {
            Group {
                switch selectedTab {
                case .house:
                    CategoryHome()
                case .search:
                    SearchView()
                case .person:
                    AccountView()
                }
            }
        } //: ZSTACK
        .animation(.default)
        .safeAreaInset(edge: .bottom) {
            CustomTabBar(selectedTab: $selectedTab)
                .padding(.vertical)
                .offset(y: isAnimating ? 0 : 100)
                .animation(.easeInOut(duration: 1), value: isAnimating)
        }
        .onAppear {
            isAnimating = true
        }
    }
}

//MARK: - PREVIEW

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
