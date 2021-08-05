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
    
    @State var index  = 0
    var pageNumber = 3
    
    var body: some View {
        TabView(selection: $index) {

            MovieComponent(title: "Overview") {
                Text(film.description ?? "")
                    .foregroundColor(.white)
                    .font(.caption)
                    .fixedSize(horizontal: false, vertical: true)
                
                CustomDivider()
                
                HorizontalComponent(title: "Rating", details: [film.rate])
                
                if let movie = film as? Movie {
                    HorizontalComponent(title: "Release Date", details: [movie.releaseDate?.toDate().toString(format: "dd/MM/yyyy") ?? ""])
                    HorizontalComponent(title: "Runtime", details: [movie.duration ?? ""])
                } else if let tvShow = film as? TvShow {
                    HorizontalComponent(title: "First Air Date", details: [tvShow.firstAirDate?.toDate().toString(format: "dd/MM/yyyy") ?? ""])
                    HorizontalComponent(title: "Episode Runtime", details: [tvShow.duration ?? ""])
                }
                
                if let languages = film.languages {
                    HorizontalComponent(title: "Languages", details: languages.compactMap( { $0.name }))
                }
                
                if let genres = film.genres {
                    HorizontalComponent(title: "Genres", details: genres.compactMap( { $0.name }))
                }
            }
            .tag(0)
            
            MovieComponent(title: "Casts") {
                if let movie = film as? Movie {
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
                } else if let tvShow = film as? TvShow {
                    if let casts = tvShow.casts {
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
            }
            .tag(1)
            
            MovieComponent(title: "Production") {
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
