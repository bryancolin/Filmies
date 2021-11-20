//
//  FilmCasts.swift
//  Filmies
//
//  Created by bryan colin on 8/5/21.
//

import SwiftUI

struct FilmCasts: View {
    
    let casts: Casts
    
    init(_ casts: Casts) {
        self.casts = casts
    }
    
    var body: some View {
        if let crews = casts.crewCategories["Director"] {
            VerticalComponent(title: "Director", urlsPath: crews.map{ $0.profilePath ?? "" }, details: crews.map{ $0.name ?? "" }, id: crews.map{ $0.id ?? -1 })
        }
        
        if let crews = casts.crewCategories["Writer"] {
            VerticalComponent(title: "Writer", urlsPath: crews.map{ $0.profilePath ?? "" }, details: crews.map{ $0.name ?? "" }, id: crews.map{ $0.id ?? -1 })
        }
        
        if let actors = casts.cast {
            VerticalComponent(title: "Starring", urlsPath: actors.map{ $0.profilePath ?? "" }, details: actors.map{ $0.name ?? "" }, subDetails: actors.map{ $0.character ?? "" }, id: actors.map{ $0.id ?? -1 })
        }
    }
}
