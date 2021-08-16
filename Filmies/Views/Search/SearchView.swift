//
//  SearchView.swift
//  Filmies
//
//  Created by bryan colin on 7/22/21.
//

import SwiftUI

struct SearchView: View {
    
    @EnvironmentObject var modelData: ModelData
    
    @State private var searchText = ""
    @State private var isPresented = false
    
    var background: some View {
        GlassmorphismBackground(type: .right, circleColors: .constant([Color(K.BrandColors.blue), Color(K.BrandColors.pink), Color(K.BrandColors.purple)]), backgroundColors: [Color(K.BrandColors.purple), Color(K.BrandColors.pink)])
    }
    
    var title: some View {
        GeometryReader { geometry in
            TitleComponent(name: "Search", color: .white, type: .largeTitle, weight: .semibold) {
                CustomPicker(width: geometry.size.width * 0.2)
                
            }
        }
        .frame(height: 75)
    }
    
    init() {
        UITextField().returnKeyType = .search
    }
    
    var body: some View {
        ZStack {
            // Glassmorphism Background
            background
            
            ScrollView(showsIndicators: false) {
                // Title
                title
                
                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 20))
                    
                    TextField("Movies or tv-shows", text: $searchText, onCommit: {
                        if !searchText.isEmpty {
                            modelData.fetchFilms(with: "search/\(modelData.selectedType.rawValue)", name: searchText)
                            isPresented.toggle()
                        }
                    })
                    
                    if !searchText.isEmpty {
                        Button(action: { searchText = "" }) {
                            Image(systemName: "xmark")
                                .font(.system(size: 20))
                        }
                    }
                }
                .accentColor(Color(K.BrandColors.pink))
                .foregroundColor(Color(K.BrandColors.pink))
                .padding(12)
                .background(Color.white)
                .cornerRadius(5)
                .padding(.horizontal)
            }
            .fullScreenCover(isPresented: $isPresented) {
                ListView(title: "Results", category: "search/\(modelData.selectedType.rawValue)", searchText: $searchText)
                    .environmentObject(modelData)
                    .animation(.default)
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .environmentObject(ModelData())
    }
}
