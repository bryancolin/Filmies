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
        // Title
        VStack(spacing: 20) {
            HStack {
                Text("Search")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer()
                
                Button(action: {
                    numberOfColumns = numberOfColumns % 2 + 1
                }, label: {
                    Image(systemName: ((numberOfColumns % 2) != 0)  ? "rectangle.grid.1x2.fill" : "square.grid.2x2.fill")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                })
            }
            .padding(.horizontal)
            .padding(.vertical)
            
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
            
            VStack(alignment: .center) {
                if !modelData.isError {
                    CardGrid(numberOfColumns: $numberOfColumns)
                } else {
                    Text("Not Found")
                }
            }
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [Color(K.BrandColors.purple), Color(K.BrandColors.pink)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
        )
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .environmentObject(ModelData())
    }
}
