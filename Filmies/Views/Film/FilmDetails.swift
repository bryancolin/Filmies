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
    private var pageNumber: Int { return film is Movie ? 2 : 3 }
    
    var overview: some View {
        FilmComponent(title: "Overview") {
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    Text(film.rate)
                    Text("|")
                    
                    if let movie = film as? Movie {
                        Text(movie.duration)
                        Text("|")
                        Text(movie.releaseDate?.toDate().toString(format: K.dateFormat) ?? "")
                    } else if let tvShow = film as? TvShow {
                        Text(tvShow.duration)
                        Text("|")
                        Text("\(tvShow.firstAirDate?.toDate().toString(format: K.dateFormat) ?? "") - \(tvShow.lastAirDate?.toDate().toString(format: K.dateFormat) ?? "")")
                    }
                }
            }
            .font(.caption)
            
            Text(film.description)
                .font(.subheadline)
                .fixedSize(horizontal: false, vertical: true)
            
            CustomDivider()
            
            if let languages = film.languages {
                HorizontalComponent(title: "Languages", details: languages.compactMap{ $0.name })
            }
            
            if let genres = film.genres {
                HorizontalComponent(title: "Genres", details: genres.compactMap{ $0.name })
            }
            
            if let countries = film.productionCountries {
                HorizontalComponent(title: "Production Countries", details: countries.compactMap{ $0.name })
            }
            
            if let companies = film.productionCompanies {
                HorizontalComponent(title: "Production Companies", details: companies.compactMap{ $0.name })
            }
        }
    }
    
    var casts: some View {
        FilmComponent(title: "Casts") {
            if let movie = film as? Movie, let casts = movie.casts {
                FilmCasts(casts)
            } else if let tvShow = film as? TvShow, let casts = tvShow.casts, let creators = tvShow.creators {
                if !creators.isEmpty {
                    VerticalComponent(title: "Creators", urls: creators.compactMap{ $0.profileURL }, details: creators.compactMap{ $0.name }, id: creators.compactMap{ $0.id })
                }
                FilmCasts(casts)
            }
        }
    }
    
    var seasons: some View {
        FilmComponent(title: "Seasons") {
            if let tvShow = film as? TvShow, let seasons = tvShow.seasons {
                FilmSeasons(seasons, poster: film.posterURL)
            }
        }
    }
    
    var body: some View {
        TabView(selection: $index) {
            
            overview.tag(0)
            
            casts.tag(1)
            
            if film is TvShow {
                seasons.tag(2)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .frame(height: UIScreen.main.bounds.height - 100)
        .background(Color.black.opacity(0.75))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(alignment: .topTrailing) {
            PageControl(numberOfPages: pageNumber, currentpage: $index)
                .frame(width: CGFloat(pageNumber * 18))
                .padding()
        }
    }
}

