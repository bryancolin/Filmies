//
//  FilmCategory.swift
//  Filmies
//
//  Created by bryan colin on 7/9/21.
//

import SwiftUI

struct FilmCategory: View {
    
    @ObservedObject var modelData = ModelData()
    
    var body: some View {
        NavigationView {
            List(modelData.movies) { movie in
                CategoryItem(movie: movie)
            }
            .navigationTitle("Film")
        }
        .onAppear {
            modelData.fetchMovies()
        }
    }
}

struct FilmCategory_Previews: PreviewProvider {
    static var previews: some View {
        FilmCategory()
    }
}
