//
//  CardElementView.swift
//  Filmies
//
//  Created by bryan colin on 7/13/21.
//

import SwiftUI

struct CardElementView: View {
    
    @State private var showingModal = false
    
    var movie: Movie
    var index: Int
    var category: String 
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        ZStack {
            Button(action: {
                showingModal.toggle()
            }) {
                Text("View")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 25)
                    .background(Color("BrandPink"))
                    .clipShape(Capsule())
            }
            .padding(.leading, 20)
            .padding(.bottom, 20)
            .sheet(isPresented: $showingModal) {
                ModalView(movie: movie, category: category, showModal: self.$showingModal)
                    .environmentObject(modelData)
            }
        }
    }
}
