//
//  MovieDetails.swift
//  Filmies
//
//  Created by bryan colin on 7/24/21.
//

import SwiftUI

struct MovieDetails: View {
    
    @EnvironmentObject var modelData: ModelData
    
    var movie: Movie
    
    @State var index  = 0
    var pageNumber = 3
    
    var body: some View {
        TabView(selection: $index) {

            MovieComponent(title: "Overview") {
                Text(movie.description ?? "")
                    .foregroundColor(.white)
                    .font(.caption)
                    .fixedSize(horizontal: false, vertical: true)
                
                CustomDivider()
                
                HorizontalComponent(title: "Rating", details: [movie.rate])
                
                HorizontalComponent(title: "Release Date", details: [movie.releaseDate?.toDate().toString(format: "dd/MM/yyyy") ?? ""])
                
                HorizontalComponent(title: "Runtime", details: [movie.duration ?? ""])
                
                if let languages = movie.languages {
                    HorizontalComponent(title: "Languages", details: languages.compactMap( { $0.name }))
                }
                
                if let genres = movie.genres {
                    HorizontalComponent(title: "Genres", details: genres.compactMap( { $0.name }))
                }
            }
            .tag(0)
            
            MovieComponent(title: "Casts") {
                if let casts = movie.casts {
                    if let crews = casts.crewCategories["Director"] {
                        VerticalComponent(title: "Director", urls: crews.compactMap({ $0.imageURL }), details: crews.compactMap({ $0.name }))
                    }
                    
                    if let crews = casts.crewCategories["Writer"] {
                        VerticalComponent(title: "Writer", urls: crews.compactMap({ $0.imageURL }), details: crews.compactMap({ $0.name }))
                    }
                    
                    if let actors = casts.cast {
                        VerticalComponent(title: "Starring", urls: actors.compactMap({ $0.imageURL }), details: actors.compactMap({ $0.name }))
                    }
                }
            }
            .tag(1)
            
            MovieComponent(title: "Production") {
                if let countries = movie.productionCountries {
                    HorizontalComponent(title: "Countries", details: countries.compactMap({ $0.name }))
                }
                
                if let companies = movie.productionCompanies {
                    HorizontalComponent(title: "Companies", details: companies.compactMap({ $0.name }))
                }
            }
            .tag(2)
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .frame(height: UIScreen.main.bounds.height + 150)
        .background(Color.black.opacity(0.75))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(
            PageControl(numberOfPages: pageNumber, currentpage: $index)
                .frame(width: CGFloat(pageNumber * 18))
                .padding(),
            alignment: .topTrailing
        )
    }
}
