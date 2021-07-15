//
//  CategoryRow.swift
//  Filmies
//
//  Created by bryan colin on 7/10/21.
//

import SwiftUI

struct CategoryRow: View {
    
    @State var categoryName: String
    var movies: [Movie]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(categoryName)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.leading, 15)
                .padding(.top, 5)
                .foregroundColor(Color("BrandPink"))
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top) {
                    ForEach(movies) { movie in
                        CategoryItem(movie: movie)
                    }
                }
            }
        }
    }
}

//struct CategoryRow_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryRow(categoryName: "Now Playing", movies: ModelData().sampleMovies)
//            .previewLayout(.sizeThatFits)
//    }
//}
