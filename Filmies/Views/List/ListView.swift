//
//  ListItem.swift
//  Filmies
//
//  Created by bryan colin on 8/12/21.
//

import SwiftUI

struct ListView: View {
    
    //MARK: - PROPERTIES
    
    @EnvironmentObject var modelData: ModelData
    @Environment(\.presentationMode) var presentationMode
    
    var title: String
    var category: String
    @Binding var searchText: String
    
    @State private var isToggle: Bool = false
    
    init(title: String, category: String, searchText: Binding<String>) {
        self.title = title
        self.category = category
        self._searchText = searchText
        
        UITableView.appearance().backgroundColor = .clear
    }
    
    //MARK: - BODY
    
    var background: some View {
        GlassmorphismBackground(type: .left, circleColors: .constant([Color(K.BrandColors.purple), Color(K.BrandColors.pink), Color(K.BrandColors.blue)]), backgroundColors: [Color.black], blurRadius: 100)
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                if let films = modelData.films[category] {
                    if #available(iOS 16.0, *) {
                        List {
                            content(of: films)
                        } //: LIST
                        .scrollContentBackground(.hidden)
                        .background(background)
                    } else {
                        List {
                            content(of: films)
                        } //: LIST
                        .background(background)
                    }
                } else {
                    Text("Not Found")
                        .font(.caption)
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                }
            } //: VSTACK
            .navigationTitle(title)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    IconButton(title: isToggle ? "square.fill.text.grid.1x2" : "square.split.1x2.fill") {
                        isToggle.toggle()
                    }
                    .foregroundColor(.white)
                }
            }
        } //: NAVIGATION VIEW
        .animation(.default)
    }
    
    // MARK: - FUNCTIONS
    @ViewBuilder
    func content(of films: [Film]) -> some View {
        ForEach(films) { film in
            ListItem(film: film, category: category, isToggle: $isToggle)
                .onAppear {
                    if film.id == films.last?.id && (films.count % 20 == 0) && !category.contains("favorites") {
                        Task {
                            await modelData.fetchFilms(with: category, name: searchText, pageNumber: (films.count / 20) + 1)
                        }
                    }
                } //: LIST ITEM
        } //: LOOP
        .listRowBackground(Blur(style: .dark))
    }
}

//MARK: - PREVIEW

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(title: "Now Playing", category: "movie/now_playing", searchText: .constant(""))
            .environmentObject(ModelData())
    }
}
