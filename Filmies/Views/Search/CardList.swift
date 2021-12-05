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
        if let films =  modelData.films[category] {
            GeometryReader { geometry in
                let height = geometry.size.height
                
                Button(action: {
                    isPresented.toggle()
                }) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(title)
                                .font(.headline)
                                .fontWeight(.semibold)
                            
                            Text(modelData.selectedType.rawValue.capitalized)
                                .font(.subheadline)
                            
                            Spacer()
                        } //: VSTACK
                        Spacer()
                    } //: HSTACK
                    .padding()
                    .background(Color.black.opacity(0.75))
                } //: BUTTON
                .background(
                    CustomImage(urlPath: films.first?.backdropPath)
                        .frame(height: height)
                )
                .foregroundColor(.white)
                .frame(width: geometry.size.width)
                .cornerRadius(8)
                .fullScreenCover(isPresented: $isPresented) {
                    ListView(title: title, category: category, searchText: .constant(""))
                        .environmentObject(modelData)
                }
            }
            .frame(height: 100)
        }
    }
}

//MARK: - PREVIEW

struct CardList_Previews: PreviewProvider {
    static var previews: some View {
        CardList(title: "Now Playing", category: "movie/now_playing")
            .environmentObject(ModelData())
    }
}

