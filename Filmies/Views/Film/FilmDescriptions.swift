//
//  FilmDescriptions.swift
//  Filmies
//
//  Created by bryan colin on 8/5/21.
//

import SwiftUI

struct FilmDescriptions: View {
    
    var type: FilmType
    var date: String
    var duration: String
    
    var body: some View {
        HorizontalComponent(title: type == .movie ? "Runtime" : "Episode Runtime", details: [duration])
        HorizontalComponent(title: type == .movie ? "Release Date" : "First Air Date", details: [date])
    }
}

struct FilmDescriptions_Previews: PreviewProvider {
    static var previews: some View {
        FilmDescriptions(type: .movie, date: "10/06/2000", duration: "2h")
    }
}
