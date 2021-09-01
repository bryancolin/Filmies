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
    
    var id: Int
    
    var background: some View {
        GlassmorphismBackground(type: .left, circleColors: .constant([Color(K.BrandColors.purple), Color(K.BrandColors.pink), Color(K.BrandColors.blue)]), backgroundColors: [Color.black], blurRadius: 100)
    }
    
    var body: some View {
        ZStack {
            // Background
            background
            // Component
            ScrollView(.vertical, showsIndicators: false) {
                if let people = modelData.people[id] {
                    CustomImage(urlString: people.profileURL, placeholder: people.name ?? "")
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
                            Text(people.name ?? "")
                                .font(.title)
                                .padding(),
                            alignment: .bottomTrailing
                        )
                        .frame(maxWidth: UIScreen.main.bounds.width)
                    
                    VStack(alignment: .leading) {
                        HorizontalComponent(title: "From", details: [people.birthPlace ?? "-"])
                        HorizontalComponent(title: "Date of Birth", details: [people.birthday?.toDate().toString(format: K.dateFormat) ?? "-"])
                        
                        Text(people.biography ?? "")
                            .font(.subheadline)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        CategoryRow(title: "Movies", color: .white, category: "person/\(id)/movie")
                            .padding(.horizontal, -15)
                        CategoryRow(title: "Tv Shows", color: .white, category: "person/\(id)/tv")
                            .padding(.horizontal, -15)
                    }
                    .padding()
                }
            }
        }
        .ignoresSafeArea()
        .onAppear {
            modelData.fetchPeople(id: id)
        }
    }
}
