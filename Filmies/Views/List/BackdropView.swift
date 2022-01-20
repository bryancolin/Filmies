//
//  BackdropView.swift
//  Filmies
//
//  Created by bryan colin on 1/19/22.
//

import SwiftUI

struct BackdropView: View {
    
    //MARK: - PROPERTIES
    
    @EnvironmentObject var modelData: ModelData
    @State private var showingModal = false
    
    var film: Film
    var category: String
    
    private var title: String {
        if let tvShow = film as? TvShow {
            return tvShow.name ?? ""
        }
        return film.title ?? ""
    }
    
    //MARK: - BODY
    
    var body: some View {
        ZStack(alignment: .bottom) {
            CustomImage(urlPath: film.backdropPath)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(alignment: .trailing) {
                Text(title)
                    .font(.headline)
                    .fontWeight(.black)
                    .multilineTextAlignment(.trailing)
            } //: VSTACK
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color.black, Color.clear]) , startPoint: .bottom , endPoint: .top))
        } //: ZSTACK
        .cornerRadius(8)
        .onTapGesture {
            showingModal.toggle()
        }
        .sheet(isPresented: $showingModal) {
            FilmView(film: film, category: category)
                .environmentObject(modelData)
        }
    }
}

//MARK: - PREVIEW

struct BackdropView_Previews: PreviewProvider {
    static var previews: some View {
        BackdropView(film: Film.getPlaceholderData()[0], category: "movie/now_playing")
    }
}
