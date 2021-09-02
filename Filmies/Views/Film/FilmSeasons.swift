//
//  FilmSeasons.swift
//  Filmies
//
//  Created by bryan colin on 8/6/21.
//

import SwiftUI

struct FilmSeasons: View {
    
    let seasons: [Season]
    let poster: String
    
    init(_ seasons: [Season], poster: String) {
        self.seasons = seasons
        self.poster = poster
    }
    
    var body: some View {
        ForEach(seasons) { season in
            VStack(alignment: .leading) {
                HStack {
                    CustomImage(urlString: !season.posterURL.isEmpty ? season.posterURL : poster)
                        .frame(width: 100)
                        .cornerRadius(8)
                    
                    VStack {
                        HorizontalComponent(title: "Season", details: [String(season.number ?? 0)])
                        HorizontalComponent(title: "Total Episode", details: [String(season.totalEpisode ?? 0)])
                        HorizontalComponent(title: "Air Date", details: [season.airDate?.toDate().toString(format: "dd/MM/yyyy") ?? ""])
                    }
                }
            }
        }
        
    }
}
