//
//  AccountView.swift
//  Filmies
//
//  Created by bryan colin on 7/29/21.
//

import SwiftUI

struct AccountView: View {
    
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        ZStack(alignment: .top) {
            Color(K.BrandColors.darkBlue)
                .ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(alignment: .leading) {
                    LargeTitle(name: "Account", color: .white, type: .largeTitle, weight: .bold) {}
                    
                    ChartView()
                    
                    // Scroll Tab for Favorites Movies
                    ScrollTabView(titles: ["Favorites"], selectedIndex: .constant(0))
                    CategoryRow(category: .constant(K.MovieCategory.favorites))
                }
            }
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
            .environmentObject(ModelData())
    }
}
