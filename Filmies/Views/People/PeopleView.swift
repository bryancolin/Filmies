//
//  PeopleView.swift
//  Filmies
//
//  Created by bryan colin on 9/1/21.
//

import SwiftUI

struct PeopleView: View {
    
    //MARK: - PROPERTIES
    
    @EnvironmentObject var modelData: ModelData
    @Environment(\.presentationMode) var presentationMode
    
    @State var opacity: Double = 0
    @State var showMore: Bool = false
    
    var id: Int
    var name, urlPath: String
    
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
            .padding(10)
            .background(Blur(style: .dark).opacity(1 - opacity))
            .clipShape(Circle())
            
            Spacer()
            
            Text(name)
                .font(.title3)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .opacity(opacity)
            
            Spacer()
            
            IconButton(title: "star") {}
            .padding(10)
            .background(Blur(style: .dark).opacity(1 - opacity))
            .clipShape(Circle())
        } //: HSTACK
        .padding()
        .padding(.top, UIApplication.shared.isTopSafeAreaAvailable() ? 30 : 0)
        .background(Blur(style: .dark).opacity(opacity))
    }
    
    //MARK: - BODY
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            //MARK: - BACKGROUND
            background
            
            //MARK: - COMPONENT
            ScrollView(.vertical, showsIndicators: false) {
                
                CustomImage(urlPath: urlPath, placeholder: name)
                    .frame(maxWidth: UIScreen.main.bounds.width)
                    .overlay(alignment: .bottomTrailing) {
                        Text(name)
                            .font(.title)
                            .fontWeight(.black)
                            .lineLimit(2)
                            .multilineTextAlignment(.trailing)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .background(LinearGradient(gradient: Gradient(colors: [Color.black, Color.clear]) , startPoint: .bottom , endPoint: .top))
                            .opacity(1 - opacity)
                    }
                    .overlay(alignment: .topTrailing) {
                        GeometryReader { proxy -> Color in
                            DispatchQueue.main.async {
                                let offset = proxy.frame(in:. global).minY + UIScreen.main.bounds.height / 1.5
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
                        } //: GEOMETRY READER
                    } //: IMAGE
                
                if let people = modelData.people[id] {
                    //MARK: - DETAILS
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
                                    } //: VSTACK
                                    .frame(width: width)
                                    
                                    Rectangle().frame(width: 1)
                                    
                                    VStack {
                                        Spacer()
                                        Text(birthday.toDate().toString(format: K.DateFormat.defaultOne))
                                        Spacer()
                                        Text("Date of Birth").font(.caption)
                                    } //: VSTACK
                                    .frame(width: width)
                                } //: HSTACK
                                .font(.headline)
                                .lineLimit(2)
                                .minimumScaleFactor(0.5)
                                .multilineTextAlignment(.center)
                                .padding(.trailing)
                            } //: GEOMETRY READER
                            .frame(height: 75)
                            .padding(.trailing)
                            .padding(10)
                            .background(Color.white.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                        
                        //MARK: - BIOGRAPHY
                        
                        if let biography = people.biography, let count = biography.wordCount, !biography.isEmpty {
                            VStack(alignment: .leading) {
                                Text(biography)
                                    .font(.subheadline)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .lineLimit(count > 50 ? (showMore ? nil : 10) : nil)
                                
                                if count > 50 {
                                    Button(action: {
                                        withAnimation {
                                            showMore.toggle()
                                        }
                                    }) {
                                        Text(showMore ? "read less" : "read more")
                                            .font(.caption)
                                    } //: BUTTON
                                    .foregroundColor(Color.secondary)
                                }
                            } //: VSTACK
                        }
                        
                        VStack {
                            CategoryRow(title: "Movies", color: .white, category: String(id) + K.People.movie)
                            CategoryRow(title: "Tv Shows", color: .white, category: String(id) + K.People.tv)
                        } //: VSTACK
                        .padding(.horizontal, -15)
                    } //: VSTACK
                    .padding()
                }
            } //: SCROLLVIEW
        } //: ZSTACK
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

//MARK: - PREVIEW

struct PeopleView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleView(id: 1, name: "", urlPath: "")
            .environmentObject(ModelData())
    }
}

