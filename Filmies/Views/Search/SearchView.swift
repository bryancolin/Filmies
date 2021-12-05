//
//  SearchView.swift
//  Filmies
//
//  Created by bryan colin on 7/22/21.
//

import SwiftUI

struct SearchView: View {
    
    //MARK: - PROPERTIES
    
    @Namespace var animation
    @EnvironmentObject var modelData: ModelData
    
    @State private var searchText = ""
    @State private var isPresented = false
    
    var background: some View {
        GlassmorphismBackground(type: .right, circleColors: .constant([Color(K.BrandColors.blue), Color(K.BrandColors.pink), Color(K.BrandColors.purple)]), backgroundColors: [Color(K.BrandColors.purple), Color(K.BrandColors.pink)])
    }
    
    var title: some View {
        GeometryReader { geometry in
            TitleComponent(name: "Search", color: .white, type: .largeTitle, weight: .black) {
                CustomPicker(animation: animation)
            }
        }
        .frame(height: 75)
    }
    
    var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 20))
            
            TextField("", text: $searchText)
                .submitLabel(.search)
                .onSubmit {
                    if !searchText.isEmpty {
                        Task {
                            await modelData.fetchFilms(with: "search/\(modelData.selectedType.rawValue)", name: searchText)
                        }
                        isPresented.toggle()
                    }
                }
                .placeholder(when: searchText.isEmpty) {
                    Text("Movies or TV-shows").foregroundColor(.gray)
                }
            
            if !searchText.isEmpty {
                IconButton(title: "xmark") { searchText = "" }
            }
        }
        .accentColor(Color(K.BrandColors.pink))
        .foregroundColor(Color(K.BrandColors.pink))
        .padding(12)
        .background(Color.white)
        .cornerRadius(5)
        .padding(.horizontal)
    }
    
    //MARK: - BODY
    
    var body: some View {
        // GLASSMORPHISM BACKGROUND
        background
        
        ScrollView(showsIndicators: false) {
            // TITLE
            title
            
            // PINNED SEARCH BAR
            LazyVStack(alignment: .leading, pinnedViews: [.sectionHeaders]) {
                Section(header: searchBar.animation(.none)) {
                    //Content
                    let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 2)
                    
                    LazyVGrid(columns: columns, spacing: 10) {
                        let subtitles = [(modelData.selectedType == .movie ? "Upcoming" : "On The Air"), "Popular"]
                        
                        ForEach(0..<subtitles.count) {
                            let count = (modelData.movieParams.count - 1) - $0
                            CardList(title: subtitles[$0], category: modelData.selectedType == .movie ? modelData.movieParams[count] : modelData.tvShowParams[count])
                        } //: LOOP
                    } //: LAZYVGRID
                    .padding(.horizontal)
                } //: SECTION
            } //: LAZYVSTACK
        } //: SCROLLVIEW
        .fullScreenCover(isPresented: $isPresented) {
            ListView(title: "Results", category: "search/\(modelData.selectedType.rawValue)", searchText: $searchText)
                .environmentObject(modelData)
        }
    }
}

//MARK: - PREVIEW

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .environmentObject(ModelData())
    }
}
