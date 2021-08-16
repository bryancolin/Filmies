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
            TitleComponent(name: "Search", color: .white, type: .largeTitle, weight: .bold) {
                CustomPicker(width: geometry.size.width * 0.2)
               
            }
        }
        .frame(height: 75)
    }
    
    var body: some View {
        ZStack {
            // Glassmorphism Background
            background
            
            VStack(spacing: 10) {
                // Title
                title
                
                // Search Bar
                HStack {
                    TextField("Type here...", text: $searchText)
                    
                    Button(action: {
                        if !searchText.isEmpty {
                            modelData.fetchFilms(with: "search/\(modelData.selectedType.rawValue)", name: searchText)
                            isPresented.toggle()
                        }
                    }) {
                        Image(systemName: "arrow.up.forward.circle.fill")
                            .font(.system(size: 25, weight: .semibold))
                    }
                }
                .accentColor(Color(K.BrandColors.pink))
                .foregroundColor(Color(K.BrandColors.pink))
                .padding(12)
                .background(Color.white)
                .cornerRadius(8)
                .padding(.horizontal)
                
                Spacer()
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
