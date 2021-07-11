//
//  CategoryItem.swift
//  Filmies
//
//  Created by bryan colin on 7/9/21.
//

import SwiftUI

struct CategoryItem: View {
    
    var movie: Movie
    
    var body: some View {
        VStack {
            Text(movie.title)
            Text("https://image.tmdb.org/t/p/w500" + movie.imageURL)
        }
    }
}

struct CategoryItem_Previews: PreviewProvider {
    static var previews: some View {
        CategoryItem(movie: ModelData().movies[0])
    }
}
