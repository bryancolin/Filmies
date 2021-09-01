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
            VerticalComponent(title: "Director", urls: crews.compactMap{ $0.imageURL }, details: crews.compactMap{ $0.name }, id: crews.compactMap{ $0.id })
        }
        
        if let crews = casts.crewCategories["Writer"] {
            VerticalComponent(title: "Writer", urls: crews.compactMap{ $0.imageURL }, details: crews.compactMap{ $0.name }, id: crews.compactMap{ $0.id })
        }
        
        if let actors = casts.cast {
            VerticalComponent(title: "Starring", urls: actors.compactMap{ $0.imageURL }, details: actors.compactMap{ $0.name },
                              subDetails: actors.compactMap{ $0.character }, id: actors.compactMap{ $0.id })
        }
    }
}
