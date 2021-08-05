//
//  FilmDetails.swift
//  Filmies
//
//  Created by bryan colin on 7/24/21.
//

import SwiftUI

struct FilmDetails: View {
    
    @EnvironmentObject var modelData: ModelData
    
    var film: Film
    
    @State var index = 0
    var pageNumber = 3
    
    var body: some View {
        TabView(selection: $index) {

            FilmComponent(title: "Overview") {
                Text(film.description ?? "")
                    .foregroundColor(.white)
                    .font(.caption)
                    .fixedSize(horizontal: false, vertical: true)
                
                CustomDivider()
                
                HorizontalComponent(title: "Rating", details: [film.rate])
                
                if let movie = film as? Movie {
                    FilmDescriptions(type: .movie, date: movie.releaseDate?.toDate().toString(format: "dd/MM/yyyy") ?? "", duration: movie.duration ?? "")
                } else if let tvShow = film as? TvShow {
                    FilmDescriptions(type: .tvShow, date: tvShow.firstAirDate?.toDate().toString(format: "dd/MM/yyyy") ?? "", duration: tvShow.duration ?? "")
                }
                
                if let languages = film.languages {
                    HorizontalComponent(title: "Languages", details: languages.compactMap( { $0.name }))
                }
                
                if let genres = film.genres {
                    HorizontalComponent(title: "Genres", details: genres.compactMap( { $0.name }))
                }
            }
            .tag(0)
            
            FilmComponent(title: "Casts") {
                if let movie = film as? Movie {
                    if let casts = movie.casts {
                        FilmCasts(casts)
                    }
                } else if let tvShow = film as? TvShow {
                    if let casts = tvShow.casts {
                        FilmCasts(casts)
                    }
                }
            }
            .tag(1)
            
            FilmComponent(title: "Production") {
                if let countries = film.productionCountries {
                    HorizontalComponent(title: "Countries", details: countries.compactMap({ $0.name }))
                }
                
                if let companies = film.productionCompanies {
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
