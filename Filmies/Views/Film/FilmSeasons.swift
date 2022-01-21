//
//  FilmSeasons.swift
//  Filmies
//
//  Created by bryan colin on 8/6/21.
//

import SwiftUI

struct FilmSeasons: View {
    
    //MARK: - PROPERTIES
    
    let seasons: [Season]
    let posterPath: String?
    
    init(_ seasons: [Season], posterPath: String?) {
        self.seasons = seasons
        self.posterPath = posterPath
    }
    
    //MARK: - BODY
    
    var body: some View {
        ForEach(seasons) { season in
            FilmSeasonDetails(season: season, posterPath: posterPath)
        } //: LOOP
    }
}

struct FilmSeasonDetails: View {
    
    //MARK: - PROPERTIES
    
    @EnvironmentObject var modelData: ModelData
    
    let season: Season
    let posterPath: String?
    
    @State private var episodes: [Episode] = []
    @State private var loadMore: Bool = false
    
    //MARK: - BODY
    
    var body: some View {
        HStack {
            CustomImage(urlPath: (season.posterPath != nil) ? season.posterPath : posterPath)
                .frame(width: 100)
                .cornerRadius(8)
            
            VStack(alignment: .leading) {
                Text("Season \(season.number ?? 0)")
                    .fontWeight(.bold)
                
                Text("\(season.totalEpisode ?? 0) episodes • \(season.airDate?.toDate().toString(format: "dd/MM/yyyy") ?? "")")
                    .font(.caption)
                    .opacity(0.5)
                
                Button(action: {
                    withAnimation {
                        loadMore = !loadMore
                    }
                    
                    Task {
                        if episodes.isEmpty {
                            episodes = await (modelData.fetchEpisodes(seasonId: season.number ?? 0) ?? [])
                        }
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
            GroupBox() {
                DisclosureGroup {
                    ForEach(episodes) { episode in
                        CustomDivider().padding(.vertical, 2)
                        
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
    }
}
