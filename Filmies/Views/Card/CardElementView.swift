//
//  CardElementView.swift
//  Filmies
//
//  Created by bryan colin on 7/13/21.
//

import SwiftUI

struct CardElementView: View {
    
    @EnvironmentObject var modelData: ModelData
    
    @State private var showingModal = false
    
    var film: Film
    var category: String
    
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        if width > 0 && height > 0 {
            CustomImage(urlString: film.posterUrl)
                .frame(width: width, height: height)
                .cornerRadius(15)
                .overlay(
                    Button(action: {
                        showingModal.toggle()
                    }) {
                        Text("View")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.vertical, 6)
                            .padding(.horizontal, 25)
                            .background(Color(K.BrandColors.pink))
                            .clipShape(Capsule())
                    }
                    .padding(),
                    alignment: .bottomLeading
                )
                .sheet(isPresented: $showingModal) {
                    ModalView(film: film, category: category, showModal: self.$showingModal)
                        .environmentObject(modelData)
                }
        }
    }
}
