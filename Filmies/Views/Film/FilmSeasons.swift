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
            HStack {
                CustomImage(urlString: !season.posterURL.isEmpty ? season.posterURL : poster)
                    .frame(width: 100)
                    .cornerRadius(8)
                
                VStack(alignment: .leading) {
                    Text("Season \(season.number ?? 0)")
                        .fontWeight(.bold)
                    
                    HStack {
                        Text("\(season.totalEpisode ?? 0) episodes")
                        Text("•")
                        Text(season.airDate?.toDate().toString(format: "dd/MM/yyyy") ?? "")
                    }
                    .font(.caption)
                    .opacity(0.5)
                }
                
                Spacer()
            }
        }
    }
}
