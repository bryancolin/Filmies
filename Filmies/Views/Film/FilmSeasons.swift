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
                }
                
                Spacer()
            }
        }
    }
}

