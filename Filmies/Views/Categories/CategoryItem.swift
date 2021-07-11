//
//  CategoryItem.swift
//  Filmies
//
//  Created by bryan colin on 7/9/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct CategoryItem: View {
    
    var movie: Movie
    
    var body: some View {
        VStack(alignment: .leading) {
            WebImage(url: URL(string: movie.imageURL))
                .resizable()
                .frame(width: 150, height: 220, alignment: .leading)
                .cornerRadius(8)
            Text(movie.title)
                .frame(width: 150, alignment: .leading)
                .font(.body)
                .foregroundColor(Color("BrandPink"))
        }
        .padding(.leading, 15)
    }
}

struct CategoryItem_Previews: PreviewProvider {
    static var previews: some View {
        CategoryItem(movie: ModelData().movies[0])
    }
}
