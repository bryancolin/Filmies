//
//  CardElementView.swift
//  Filmies
//
//  Created by bryan colin on 7/13/21.
//

import SwiftUI

struct CardElementView: View {
    
    //MARK: - PROPERTIES
    
    @EnvironmentObject var modelData: ModelData
    
    @State private var showingModal = false
    
    var film: Film
    var category: String
    
    var width: CGFloat
    var height: CGFloat
    
    //MARK: - BODY
    
    var body: some View {
        if width > 0 && height > 0 {
            CustomImage(urlPath: film.posterPath)
                .frame(width: width, height: height)
                .cornerRadius(15)
                .overlay(alignment: .bottomLeading) {
                    Button(action: {
                        showingModal.toggle()
                    }) {
                        Text("View")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.vertical, 6)
                            .padding(.horizontal, 25)
                            .background(Color(K.BrandColors.pink))
                            .clipShape(Capsule())
                    }
                    .padding()
                }
                .sheet(isPresented: $showingModal) {
                    FilmView(film: film, category: category)
                        .environmentObject(modelData)
                }
        }
    }
}

//MARK: - PREVIEW

struct CardElementView_Previews: PreviewProvider {
    static var previews: some View {
        CardElementView(film: Film.getPlaceholderData()[0], category: "movie/now_playing", width: 250, height: 300)
            .environmentObject(ModelData())
    }
}
