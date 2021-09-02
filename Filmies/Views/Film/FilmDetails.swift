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
    private var pageNumber: Int { return film is Movie ? 3 : 4 }
    
    var overview: some View {
        FilmComponent(title: "Overview") {
            Text(film.description)
                .font(.subheadline)
                .fixedSize(horizontal: false, vertical: true)
            
            CustomDivider()
            
            HorizontalComponent(title: "Rating", details: [film.rate])
            
            if let movie = film as? Movie {
                FilmDescriptions(type: .movie, date: movie.releaseDate?.toDate().toString(format: K.dateFormat) ?? "", duration: movie.duration )
            } else if let tvShow = film as? TvShow {
                FilmDescriptions(type: .tvShow, date: tvShow.firstAirDate?.toDate().toString(format: K.dateFormat) ?? "", duration: tvShow.duration )
                HorizontalComponent(title: "Last Air Date", details: [tvShow.lastAirDate?.toDate().toString(format: K.dateFormat) ?? ""])
            }
            
            if let languages = film.languages {
                HorizontalComponent(title: "Languages", details: languages.compactMap{ $0.name })
            }
            
            if let genres = film.genres {
                HorizontalComponent(title: "Genres", details: genres.compactMap{ $0.name })
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
    
    var productions: some View {
        FilmComponent(title: "Production") {
            if let countries = film.productionCountries {
                HorizontalComponent(title: "Countries", details: countries.compactMap{ $0.name })
            }
            
            if let companies = film.productionCompanies {
                HorizontalComponent(title: "Companies", details: companies.compactMap{ $0.name })
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
            
            productions.tag(2)
            
            if film is TvShow {
                seasons.tag(3)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .frame(height: UIScreen.main.bounds.height - 100)
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

