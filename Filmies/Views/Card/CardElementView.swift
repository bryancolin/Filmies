//
//  CardElementView.swift
//  Filmies
//
//  Created by bryan colin on 7/13/21.
//

import SwiftUI

struct CardElementView: View {
    
    var movie: Movie
    @State private var showingModal = false
    
    var body: some View {
        Spacer()
        Button(action: {
            showingModal.toggle()
        }) {
            Text("View")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.vertical, 6)
                .padding(.horizontal, 25)
                .background(Color.blue)
                .clipShape(Capsule())
        }
        .sheet(isPresented: $showingModal) {
            ModalView(movie: movie, showModal: self.$showingModal)
        }
        .padding(.leading, 20)
        .padding(.bottom, 20)
    }
}
