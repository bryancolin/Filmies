//
//  FavoritesView.swift
//  Filmies
//
//  Created by bryan colin on 7/27/21.
//

import SwiftUI

struct FavoritesView: View {
    
    @EnvironmentObject var modelData: ModelData
    
    var gradient: LinearGradient {
        LinearGradient (
            gradient: Gradient(colors: [Color(K.BrandColors.blue), Color(K.BrandColors.purple)]),
            startPoint: .top,
            endPoint: .bottom
        )
    }
    
    var body: some View {
        VStack(spacing: 10) {
            // Title
            HStack {
                Text("Favorites")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color(K.BrandColors.pink))
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.vertical)
            
            // Card Grid
            VStack(alignment: .center) {
                CardGrid(category: "favorites", numberOfColumns: .constant(2))
            }
        }
        .background(
            gradient.ignoresSafeArea()
        )
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
            .environmentObject(ModelData())
    }
}
