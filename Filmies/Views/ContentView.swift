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
        ZStack(alignment: .bottom) {
            switch selectedTab {
            case .house:
                CategoryHome()
            default:
                Color.white
            }
            
            CustomTabBar(selectedTab: $selectedTab)
                .padding(.vertical)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
