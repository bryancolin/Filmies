//
//  FilmDetails.swift
//  Filmies
//
//  Created by bryan colin on 7/24/21.
//

import SwiftUI

struct FilmDetails: View {
    
    //MARK: - PROPERTIES
    
    @EnvironmentObject var modelData: ModelData
    
    var film: Film
    
    @State var index = 0
    private var pageNumber: Int { return film is Movie ? 2 : 3 }
    
    //MARK: - OVERVIEW
    var overview: some View {
        FilmComponent(title: "Overview") {
            
            //MARK: - DETAILS
            if let movie = film as? Movie {
                FilmDescriptions(date: movie.releaseDate?.toDate().toString(format: K.DateFormat.defaultOne) ?? "", duration: movie.duration, rate: film.rate)
            } else if let tvShow = film as? TvShow {
                FilmDescriptions(date: tvShow.firstAirDate?.toDate().toString(format: K.DateFormat.defaultOne) ?? "", duration: tvShow.duration, rate: film.rate)
            }
            
            //MARK: - DESCRIPTIONS
            if !film.description.isEmpty {
                VStack(alignment: .leading) {
                    Text(film.description)
                        .font(.subheadline)
                        .fixedSize(horizontal: false, vertical: true)
                } //: VSTACK
                
                CustomDivider()
            }
            
            //MARK: - LANGUAGES
            if let languages = film.languages?.compactMap { $0.name } {
                HorizontalComponent(title: "Languages", details: languages)
            }
            
            //MARK: - GENRES
            if let genres = film.genres?.compactMap { $0.name } {
                HorizontalComponent(title: "Genres", details: genres)
            }
            
            //MARK: - PRODUCTION COUNTRIES
            if let countries = film.productionCountries?.compactMap { $0.name }  {
                HorizontalComponent(title: "Production Countries", details: countries)
            }
            
            //MARK: - PRODUCTION COMPANIES
            if let companies = film.productionCompanies?.compactMap { $0.name }  {
                HorizontalComponent(title: "Production Companies", details: companies)
            }
        }
    }
    
    //MARK: - CAST
    var casts: some View {
        FilmComponent(title: "Casts") {
            if let movie = film as? Movie, let casts = movie.casts {
                FilmCasts(casts)
            } else if let tvShow = film as? TvShow, let casts = tvShow.casts, let creators = tvShow.creators {
                if !creators.isEmpty {
                    VerticalComponent(title: "Creators", urlsPath: creators.map{ $0.profilePath ?? "" }, details: creators.map{ $0.name ?? "" }, id: creators.map{ $0.id ?? -1 })
                }
                FilmCasts(casts)
            }
        }
    }
    
    //MARK: - SEASONS
    var seasons: some View {
        FilmComponent(title: "Seasons") {
            if let tvShow = film as? TvShow, let seasons = tvShow.seasons, !seasons.isEmpty {
                FilmSeasons(seasons, posterPath: film.posterPath)
            }
        }
    }
    
    //MARK: - BODY
    
    var body: some View {
        TabView(selection: $index) {
            
            overview.tag(0)
            
            casts.tag(1)
            
            if film is TvShow {
                seasons.tag(2)
            }
        } // TAB VIEW
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

//MARK: - PREVIEW

struct FilmDetails_Previews: PreviewProvider {
    static var previews: some View {
        FilmDetails(film: Film.getPlaceholderData()[0])
            .environmentObject(ModelData())
    }
}
