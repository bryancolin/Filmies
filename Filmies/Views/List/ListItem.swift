//
//  ListItem.swift
//  Filmies
//
//  Created by bryan colin on 8/12/21.
//

import SwiftUI

struct ListItem: View {
    
    @EnvironmentObject var modelData: ModelData
    @Environment(\.presentationMode) var presentationMode
    
    var title: String
    var category: String
    
    @State var scrollViewOffset: CGFloat = 0
    @State var startOffset: CGFloat = 0
    @State var isScrollToTop = false
    
    var background: some View {
        GlassmorphismBackground(type: .left, circleColors: .constant([Color(K.BrandColors.purple), Color(K.BrandColors.pink), Color(K.BrandColors.blue)]), backgroundColors: [Color.black], blurRadius: 100)
    }
    
    var body: some View {
        ZStack {
            // Background
            background
            // Component
            ScrollViewReader { proxyReader in
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading) {
                        // Back Button
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "arrow.backward")
                                .font(.system(size: 25, weight: .semibold))
                        }
                        .padding()
                        .id("SCROLL_TO_TOP")
                        .overlay(
                            GeometryReader { proxy -> Color in
                                DispatchQueue.main.async {
                                    let offset = proxy.frame(in:. global).minY
                                    
                                    if startOffset == 0 {
                                        self.startOffset = offset
                                    }
                                    
                                    self.scrollViewOffset = offset - startOffset
                                }
                                
                                return Color.clear
                            }
                            .frame(width: 0, height: 0),
                            alignment: .top
                        )
                        
                        // Title
                        TitleComponent(name: title, color: .white, type: .largeTitle, weight: .bold, firstContent: {}, secondContent: {})
                        
                        // Cards
                        if let films = modelData.films[category] {
                            ForEach(films) { film in
                                HStack(alignment: .top) {
                                    CategoryItem(film: film, category: category)
                                        .aspectRatio(contentMode: .fit)
                                        .frame(alignment: .top)
                                    
                                    VStack(alignment: .leading) {
                                        if let tvShow = film as? TvShow {
                                            Text(tvShow.name ?? "")
                                                .font(.title3)
                                                .fontWeight(.bold)
                                                .padding(.bottom, 5)
                                        } else {
                                            Text(film.title ?? "")
                                                .font(.title3)
                                                .fontWeight(.bold)
                                                .padding(.bottom, 5)
                                        }
                                        
                                        Text(film.description ?? "No synopsis")
                                    }
                                    .padding(.horizontal)
                                }
                                .frame(height: UIScreen.main.bounds.height / 3)
                                .padding(.vertical)
                                .redacted(reason: modelData.isLoading ? .placeholder : [])
                            }
                            
                            // Load More
                            if films.count % 20 == 0 {
                                Button(action: {
                                    modelData.fetchFilms(with: category, pageNumber: (films.count / 20) + 1)
                                }) {
                                    RoundedRectangle(cornerRadius: 8)
                                        .frame(height: 50)
                                        .overlay(
                                            Text("Load more")
                                                .fontWeight(.bold)
                                                .foregroundColor(Color(K.BrandColors.pink))
                                        )
                                }
                                .padding()
                            }
                        }
                    }
                }
                .foregroundColor(.white)
                .overlay(
                    Button(action:{
                        withAnimation(Animation.linear(duration:  0.3)) {
                            isScrollToTop = true
                            proxyReader.scrollTo("SCROLL_TO_TOP", anchor: .top)
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            isScrollToTop = false
                        }
                    }) {
                        Image(systemName: "arrow.up")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color(K.BrandColors.pink))
                            .clipShape(Circle())
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    .padding(.trailing)
                    .padding(.bottom, getSafeArea().bottom == 0 ? 12 : 0)
                    .opacity(-scrollViewOffset > 450 ? 1 : 0)
                    .animation(.easeInOut)
                    .disabled(isScrollToTop),
                    alignment: .bottomTrailing
                )
            }
        }
    }
}

struct ListItem_Previews: PreviewProvider {
    static var previews: some View {
        ListItem(title: "Now Playing", category: "movie/now_playing")
            .environmentObject(ModelData())
    }
}

extension View {
    
    func getSafeArea() -> UIEdgeInsets {
        return UIApplication.shared.windows.first?.safeAreaInsets ?? UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
