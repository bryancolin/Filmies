//
//  CardGridItem.swift
//  Filmies
//
//  Created by bryan colin on 7/23/21.
//

import SwiftUI

struct CardGridItem: View {
    
    @EnvironmentObject var modelData: ModelData
    var movie: Movie
    
    @State private var showingModal = false
    
    var body: some View {
        Button(action: {
            if !modelData.isLoading {
                showingModal.toggle()
            }
        }) {
            CustomImage(urlString: movie.imageURL)
                .cornerRadius(15)
        }
        .sheet(isPresented: $showingModal) {
            ModalView(movie: movie, category: "search", showModal: self.$showingModal)
                .environmentObject(modelData)
        }
    }
}
