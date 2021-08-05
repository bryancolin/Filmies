//
//  SearchView.swift
//  Filmies
//
//  Created by bryan colin on 7/22/21.
//

import SwiftUI

struct SearchView: View {
    
    @EnvironmentObject var modelData: ModelData
    
    @State private var numberOfColumns = 2
    @State private var searchText = ""
    
    init() {
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color(K.BrandColors.pink))], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
    }
    
    var body: some View {
        ZStack {
            // Glassmorphism Background
            GlassmorphismBackground(type: .right, circleColors: .constant([Color(K.BrandColors.blue), Color(K.BrandColors.pink), Color(K.BrandColors.purple)]), backgroundColors: [Color(K.BrandColors.purple), Color(K.BrandColors.pink)])
            
            VStack(spacing: 10) {
                // Title
                GeometryReader { geometry in
                    TitleComponent(name: "Search", color: .white, type: .largeTitle, weight: .bold) {
                        
                        Picker(selection: $modelData.selectedType, label: Text("")) {
                            Text("M").tag(FilmType.movie)
                            Text("T").tag(FilmType.tv)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(width: geometry.size.width * 0.2)
                        
                        Button(action: {
                            numberOfColumns = numberOfColumns % 2 + 1
                        }) {
                            Image(systemName: ((numberOfColumns % 2) != 0)  ? "rectangle.grid.1x2.fill" : "square.grid.2x2.fill")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.white)
                        }
                    }
                }
                .frame(height: 75)
                
                // Search Bar
                HStack {
                    TextField("Type here...", text: $searchText)
                        .foregroundColor(Color(K.BrandColors.pink))
                    
                    Button(action: {
                        if !searchText.isEmpty {
                            modelData.searchFilm(type: modelData.selectedType.rawValue, name: searchText)
                        }
                    }) {
                        Image(systemName: "arrow.up.forward.circle.fill")
                            .font(.system(size: 25, weight: .semibold))
                            .foregroundColor(Color(K.BrandColors.pink))
                    }
                }
                .padding(12)
                .background(Color.white)
                .cornerRadius(20)
                .padding(.horizontal)
                
                // Card Grid
                VStack(alignment: .center) {
                    if !modelData.isError {
                        CardGrid(category: "search", numberOfColumns: $numberOfColumns)
                    } else {
                        Text("Not Found")
                    }
                }
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
