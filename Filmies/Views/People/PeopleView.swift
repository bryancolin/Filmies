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
    @State var showMore: Bool = false
    
    var id: Int
    
    var background: some View {
        GlassmorphismBackground(type: .left, circleColors: .constant([Color(K.BrandColors.purple), Color(K.BrandColors.pink), Color(K.BrandColors.blue)]), backgroundColors: [Color.black], blurRadius: 100)
    }
    
    var header: some View {
        // Back Button
        HStack {
            IconButton(title: "arrow.backward") {
                withAnimation {
                    presentationMode.wrappedValue.dismiss()
                }
            }
            
            Spacer()
            
            if let people = modelData.people[id] {
                Text(people.name ?? "")
                    .font(.title3)
                    .opacity(opacity)
            }
            
            Spacer()
            
            IconButton(title: "star") {}
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
                    CustomImage(urlPath: people.profilePath, placeholder: people.name ?? "")
                        .frame(maxWidth: UIScreen.main.bounds.width)
                        .overlay(alignment: .bottomTrailing) {
                            Text(people.name ?? "")
                                .font(.title)
                                .lineLimit(2)
                                .padding()
                        }
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
                    
                    // Details
                    VStack(alignment: .leading) {
                        if let dob = people.birthPlace, let birthday = people.birthday, !dob.isEmpty && !birthday.isEmpty {
                            GeometryReader { geometry in
                                let width = geometry.size.width / 2
                                HStack {
                                    VStack {
                                        Spacer()
                                        Text(dob)
                                        Spacer()
                                        Text("From").font(.caption)
                                    }
                                    .frame(width: width)
                                    
                                    Rectangle().frame(width: 1)
                                    
                                    VStack {
                                        Spacer()
                                        Text(birthday.toDate().toString(format: K.dateFormat))
                                        Spacer()
                                        Text("Date of Birth").font(.caption)
                                    }
                                    .frame(width: width)
                                }
                                .font(.headline)
                                .lineLimit(2)
                                .minimumScaleFactor(0.5)
                                .multilineTextAlignment(.center)
                                .padding(.trailing)
                            }
                            .frame(height: 100)
                            .padding(.trailing)
                            .padding(10)
                            .background(Color.white.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                        
                        if let biography = people.biography, !biography.isEmpty {
                            VStack(alignment: .leading) {
                                Text(biography)
                                    .font(.subheadline)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .lineLimit(showMore ? nil : 10)
                                Button(action: {
                                    withAnimation {
                                        showMore.toggle()
                                    }
                                }) {
                                    Text(showMore ? "read less" : "read more")
                                        .font(.caption)
                                        .opacity(0.5)
                                }
                            }
                        }
                        
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
            header.ignoresSafeArea()
        }
        .task {
            await modelData.fetchPeople(id: id)
        }
    }
}
