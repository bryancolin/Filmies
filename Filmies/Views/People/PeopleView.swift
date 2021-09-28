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
    
    @State var opacity: Double = 0
    
    var id: Int
    
    var background: some View {
        GlassmorphismBackground(type: .left, circleColors: .constant([Color(K.BrandColors.purple), Color(K.BrandColors.pink), Color(K.BrandColors.blue)]), backgroundColors: [Color.black], blurRadius: 100)
    }
    
    var header: some View {
        // Back Button
        HStack {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "arrow.backward")
            }
            
            Spacer()
            
            if let people = modelData.people[id] {
                Text(people.name ?? "")
                    .font(.title3)
                    .opacity(opacity)
            }
            
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "star")
            }
        }
        .padding()
        .padding(.top)
        .background(Blur(style: .dark).opacity(opacity))
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            // Background
            background
            
            // Component
            ScrollView(.vertical, showsIndicators: false) {
                if let people = modelData.people[id] {
                    CustomImage(urlString: people.profileURL, placeholder: people.name ?? "")
                        .overlay(
                            Text(people.name ?? "")
                                .font(.title)
                                .lineLimit(2)
                                .padding(),
                            alignment: .bottomTrailing
                        )
                        .frame(maxWidth: UIScreen.main.bounds.width)
                        .overlay(alignment: .topTrailing) {
                            GeometryReader { proxy -> Color in
                                DispatchQueue.main.async {
                                    let offset = proxy.frame(in:. global).minY + UIScreen.main.bounds.height / 2
                                    
                                    if offset < 80 {
                                        if offset > 0 {
                                            let opacity_value = (80 -  offset) / 80
                                            self.opacity = Double(opacity_value)
                                            return
                                        }
                                        self.opacity = 1
                                    } else {
                                        self.opacity = 0
                                    }
                                }
                                return Color.clear
                            }
                        }
                    
                    VStack(alignment: .leading) {
                        HorizontalComponent(title: "From", details: [people.birthPlace ?? "-"])
                        HorizontalComponent(title: "Date of Birth", details: [people.birthday?.toDate().toString(format: K.dateFormat) ?? "-"])
                        
                        Text(people.biography ?? "")
                            .font(.subheadline)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        VStack {
                            CategoryRow(title: "Movies", color: .white, category: String(id) + K.People.movie)
                            CategoryRow(title: "Tv Shows", color: .white, category: String(id) + K.People.tv)
                        }
                        .padding(.horizontal, -15)
                    }
                    .padding()
                }
            }
        }
        .animation(.default)
        .ignoresSafeArea()
        .safeAreaInset(edge: .top) {
            header
                .ignoresSafeArea()
        }
        .task {
            await modelData.fetchPeople(id: id)
        }
    }
}
