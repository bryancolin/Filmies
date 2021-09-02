//
//  CardList.swift
//  Filmies
//
//  Created by bryan colin on 8/17/21.
//

import SwiftUI

struct CardList: View {
    
    @EnvironmentObject var modelData: ModelData
    
    var title: String
    var category: String
    
    @State private var isPresented = false
    
    var body: some View {
        Button(action: {
            isPresented.toggle()
        }) {
            ZStack(alignment: .bottomTrailing) {
                if let movies =  modelData.films[category] {
                    CustomImage(urlString: movies.first?.posterURL ?? "")
                        .frame(width: 75, height: 100)
                        .cornerRadius(5)
                        .blur(radius: 1)
                        .offset(x: 20, y: 10)
                        .rotationEffect(.degrees(-25))
                }
                
                HStack {
                    VStack(alignment: .leading) {
                        Text(title)
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        Text(modelData.selectedType.rawValue.capitalized)
                            .font(.subheadline)
                        
                        Spacer()
                    }
                    .padding()
                    
                    Spacer()
                }
            }
        }
        .background(Color([K.BrandColors.pink, K.BrandColors.blue, K.BrandColors.darkBlue, K.BrandColors.purple].randomElement() ?? K.BrandColors.pink))
        .foregroundColor(.white)
        .frame(height: 100)
        .cornerRadius(8)
        .fullScreenCover(isPresented: $isPresented) {
            ListView(title: title, category: category, searchText: .constant(""))
                .environmentObject(modelData)
                .animation(.default)
        }
    }
}
