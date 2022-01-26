//
//  CardList.swift
//  Filmies
//
//  Created by bryan colin on 8/17/21.
//

import SwiftUI

struct CardList: View {
    
    //MARK: - PROPERTIES
    
    @EnvironmentObject var modelData: ModelData
    
    var title: String
    var category: String
    
    @State private var isPresented = false
    
    //MARK: - BODY
    
    var body: some View {
        GeometryReader { geometry in
            let height = geometry.size.height
            
            Button(action: {
                isPresented.toggle()
            }) {
                ZStack(alignment: .bottomTrailing) {
                    if let films =  modelData.films[category] {
                        CustomImage(urlPath: films.first?.posterPath)
                            .frame(width: 75, height: height)
                            .cornerRadius(8)
                            .blur(radius: 1)
                            .offset(x: 20, y: 10)
                            .rotationEffect(.degrees(-25))
                    }
                    
                    VStack(alignment: .leading) {
                        Text(title)
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        Text(modelData.selectedType.rawValue.capitalized)
                            .font(.subheadline)
                    } //: VSTACK
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                    .padding()
                } //: ZSTACK
            } //: BUTTON
            .background(Color([K.BrandColors.pink, K.BrandColors.blue, K.BrandColors.darkBlue, K.BrandColors.purple].randomElement() ?? K.BrandColors.pink))
            .foregroundColor(.white)
            .frame(width: geometry.size.width)
            .cornerRadius(8)
            .sheet(isPresented: $isPresented) {
                ListView(title: title, category: category, searchText: .constant(""))
                    .environmentObject(modelData)
            }
        } //: GEOMETRY READER
        .frame(height: 100)
    }
}

//MARK: - PREVIEW

struct CardList_Previews: PreviewProvider {
    static var previews: some View {
        CardList(title: "Now Playing", category: "movie/now_playing")
            .environmentObject(ModelData())
    }
}

