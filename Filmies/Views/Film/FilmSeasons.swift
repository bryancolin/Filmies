//
//  FilmSeasons.swift
//  Filmies
//
//  Created by bryan colin on 8/6/21.
//

import SwiftUI

struct FilmSeasons: View {
    
    //MARK: - PROPERTIES
    @EnvironmentObject var modelData: ModelData
    
    let seasons: [Season]
    let posterPath: String?
    
    @State private var selectedIndex: Int = 0
    @State private var loadMore: Bool = false
    @State private var episodes: [Episode] = []
    
    init(_ seasons: [Season], posterPath: String?) {
        self.seasons = seasons
        self.posterPath = posterPath
    }
    
    //MARK: - BODY
    
    var body: some View {
        VStack {
            //MARK: - SEASONS NUMBER
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0..<seasons.count) { index in
                        Button(action: {
                            withAnimation {
                                selectedIndex = index
                                loadMore = false
                            }
                        }) {
                            Text("\(seasons[index].number ?? 0)")
                                .padding()
                                .background(
                                    Circle() 
                                        .foregroundColor(selectedIndex == index ? Color.white.opacity(0.3) : .clear)
                                )
                        }
                    } //: LOOP
                } //: HSTACK
            } //: SCROLL VIEW
            
            //MARK: - HEADER
            HStack {
                CustomImage(urlPath: (seasons[selectedIndex].posterPath != nil) ? seasons[selectedIndex].posterPath : posterPath)
                    .frame(width: 100)
                    .cornerRadius(8)
                
                VStack(alignment: .leading) {
                    Text("Season \(seasons[selectedIndex].number ?? 0)")
                        .fontWeight(.bold)
                    
                    Text("\(seasons[selectedIndex].totalEpisode ?? 0) episodes • \(seasons[selectedIndex].airDate?.toDate().toString(format: "dd/MM/yyyy") ?? "")")
                        .font(.caption)
                        .opacity(0.5)
                    
                    Button(action: {
                        withAnimation {
                            loadMore = !loadMore
                        }
                        
                        Task {
                            episodes = await (modelData.fetchEpisodes(seasonId: seasons[selectedIndex].number ?? 0) ?? [])
                        }
                    }) {
                        Text(loadMore ? "show less" : "load more")
                            .font(.caption)
                            .opacity(0.5)
                    }
                } //: VSTACK
                
                Spacer()
            } //: HSTACK
            
            if loadMore {
                //MARK: - OVERVIEW
                VStack(alignment: .leading) {
                    Text(seasons[selectedIndex].overview ?? "")
                        .font(.subheadline)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                //MARK: - EPISODES
                GroupBox() {
                    DisclosureGroup {
                        ForEach(episodes) { episode in
                            Divider().padding(.vertical, 2)
                            
                            HStack {
                                Text("\(episode.number ?? 0). \(episode.name ?? "")")
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(1)
                                
                                Spacer()
                            } //: HSTACK
                        }
                    } label: {
                        Text("Episodes")
                            .fontWeight(.bold)
                    } //: DISCLOSURE GROUP
                    .accentColor(Color.white)
                } //: GROUP BOX
                .groupBoxStyle(TransparentGroupBox())
            }
        } //: VSTACK
    }
}
