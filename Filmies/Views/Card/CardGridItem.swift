//
//  CardGridItem.swift
//  Filmies
//
//  Created by bryan colin on 7/23/21.
//

import SwiftUI

struct CardGridItem: View {
    
    @EnvironmentObject var modelData: ModelData
    var film: Film
    var category: String
    
    @State private var showingModal = false
    
    var body: some View {
        Button(action: {
            if !modelData.isLoading {
                showingModal.toggle()
            }
        }) {
            CustomImage(urlString: film.posterURL)
                .cornerRadius(15)
        }
        .sheet(isPresented: $showingModal) {
            ModalView(film: film, category: category, showModal: self.$showingModal)
                .environmentObject(modelData)
        }
    }
}
