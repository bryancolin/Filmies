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
    
    var body: some View {
        ZStack {
            // Glassmorphism Background
            GlassmorphismBackground(type: .right, circleColors: .constant([Color(K.BrandColors.blue), Color(K.BrandColors.pink), Color(K.BrandColors.purple)]), backgroundColors: [Color(K.BrandColors.purple), Color(K.BrandColors.pink)])
            
            VStack(spacing: 10) {
                // Title
                TitleComponent(name: "Search", color: .white, type: .largeTitle, weight: .bold) {
                    Button(action: {
                        numberOfColumns = numberOfColumns % 2 + 1
                    }, label: {
                        Image(systemName: ((numberOfColumns % 2) != 0)  ? "rectangle.grid.1x2.fill" : "square.grid.2x2.fill")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                    })
                }
                
                // Search Bar
                HStack {
                    TextField("Type here...", text: $searchText)
                        .foregroundColor(Color(K.BrandColors.pink))
                    
                    Button(action: {
                        if !searchText.isEmpty {
                            modelData.searchMovie(name: searchText)
                        }
                    }, label: {
                        Image(systemName: "arrow.up.forward.circle.fill")
                            .font(.system(size: 25, weight: .semibold))
                            .foregroundColor(Color(K.BrandColors.pink))
                    })
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
