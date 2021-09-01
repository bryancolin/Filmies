//
//  PeopleView.swift
//  Filmies
//
//  Created by bryan colin on 9/1/21.
//

import SwiftUI

struct PeopleView: View {
    
    @EnvironmentObject var modelData: ModelData
    @Environment(\.presentationMode) var presentationMode
    
    var background: some View {
        GlassmorphismBackground(type: .left, circleColors: .constant([Color(K.BrandColors.purple), Color(K.BrandColors.pink), Color(K.BrandColors.blue)]), backgroundColors: [Color.black], blurRadius: 100)
    }
    
    var body: some View {
        ZStack {
            // Background
            background
            // Component
            ScrollView(.vertical, showsIndicators: false) {
                CustomImage(urlString: "")
                    .frame(height: UIScreen.main.bounds.height / 3)
                    .overlay(
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "arrow.backward")
                                .font(.system(size: 25))
                        }
                        .padding(.horizontal)
                        .padding(.top, 40),
                        alignment: .topLeading
                    )
                    .overlay(
                        Text("Name")
                            .font(.title)
                            .padding(),
                        alignment: .bottomTrailing
                    )
                    
                VStack(alignment: .leading) {
                    HorizontalComponent(title: "From", details: [""])
                    HorizontalComponent(title: "Date of Birth", details: [""])
                    
                    Text("Description")
                        .font(.subheadline)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Text("Movies")
                        .foregroundColor(.white)
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    CategoryRow(title: "Movies", color: .white, category: "movie/now_playing")
                }
                .padding()
            }
        }
        .ignoresSafeArea()
    }
}
