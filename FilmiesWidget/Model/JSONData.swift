//
//  JSONData.swift
//  FilmiesWidgetExtension
//
//  Created by bryan colin on 9/25/21.
//

import Foundation

struct JSONData: Codable {
    let all: [Detail]?
    
    enum CodingKeys: String, CodingKey {
        case all = "results"
    }
}

struct Detail: Codable {
    let title: String?
    
    let backdropPath: String?
    var backdropURL: String {
        if let url = backdropPath {
            return String("https://image.tmdb.org/t/p/w500" + url)
        }
        return posterURL
    }
    
    let posterPath: String?
    var posterURL: String {
        if let url = posterPath {
            return String("https://image.tmdb.org/t/p/w500" + url)
        }
        return String()
    }
    
    enum CodingKeys: String, CodingKey {
        case title
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
    }
    
    static let placeholderData = [
        Detail(title: "Free Guy", backdropPath: "/8Y43POKjjKDGI9MH89NW0NAzzp8.jpg", posterPath: "/yc2IfL701hGkNHRgzmF4C6VKO14.jpg"),
        Detail(title: "Intrusion", backdropPath: "/ck8zSCD4YppPjMbA8h6GDcPJPhH.jpg", posterPath: "/o6ozTBflWXlBje0uxJv4m6s4HTq.jpg"),
        Detail(title: "The Starling", backdropPath: "/1tDelhmpG8KzFdU3QvOhBScm4sS.jpg", posterPath: "/gPkaPGNbjZCeRurSYGi0JD63DBa.jpg"),
        Detail(title: "Old", backdropPath: "/iTgM25ftE7YtFgZwUZupVp8A61S.jpg", posterPath: "/cGLL4SY6jFjjUZkz2eFxgtCtGgK.jpg"),
        Detail(title: "Birds of Paradise", backdropPath: "/5n5BWIljsaeKf5wzwohjKuI7dG4.jpg", posterPath: "/h3v0rsQvik8yMh3LStRiDu0GTHP.jpg"),
        Detail(title: "Dune", backdropPath: "/aknvFyJUQQoZFtmFnYzKi4vGv4J.jpg", posterPath: "/s1FhMAr91WL8D5DeHOcuBELtiHJ.jpg"),
        Detail(title: "My Little Pony: A New Generation", backdropPath: "/ugukqzx4gSzBd1yzmbWEHLkpGaS.jpg", posterPath: "/hzq5XRGgm6NDMOW1idUvbpGqEkv.jpg"),
        Detail(title: "F9", backdropPath: "/xXHZeb1yhJvnSHPzZDqee0zfMb6.jpg", posterPath: "/bOFaAXmWWXC3Rbv4u4uM9ZSzRXP.jpg"),
        Detail(title: "Black Widow", backdropPath: "/keIxh0wPr2Ymj0Btjh4gW7JJ89e.jpg", posterPath: "/qAZ0pzat24kLdO3o8ejmbLxyOac.jpg"),
        Detail(title: "Candyman", backdropPath: "/mHU833IrBRfZ3hhzEQsiiw2D8Nc.jpg", posterPath: "/dqoshZPLNsXlC1qtz5n34raUyrE.jpg"),
        Detail(title: "Escape Room: Tournament of Champions", backdropPath: "/dsdbViTNjLu4DbgkkYmuY4xDQ20.jpg", posterPath: "/jGYJyPzVgrVV2bgClI9uvEZgVLE.jpg"),
        Detail(title: "Je suis Karl", backdropPath: "/bhTMwf7XO4mbk4plgvFjq7tzoWt.jpg", posterPath: "/jsZkLqSzMm2AcxOAAAGTlK0Giac.jpg"),
        Detail(title: "Cry Macho", backdropPath: "/g6wufgtycJCP508tlC3crSYFCgC.jpg", posterPath: "/nMFWfwer3IYTALLEiNno4SaVMbE.jpg"),
        Detail(title: "Reminiscence", backdropPath: "/8yhWlFcJ8zCqjfCvLy3lWFuawR1.jpg", posterPath: "/17siH6wJRQ2jZiqz9BWUhy1UtZ.jpg"),
        Detail(title: "The Stronghold", backdropPath: "/vkIJ2QgcKMJRvi6pBW4Tr2kgLdy.jpg", posterPath: "/nLanxl7Xhfbd5s8FxPy8jWZw4rv.jpg"),
        Detail(title: "Shang-Chi and the Legend of the Ten Rings", backdropPath: "/uizrxdqIl1a4c9UIhSdPM3o6u0f.jpg", posterPath: "/xeItgLK9qcafxbd8kYgv7XnMEog.jpg"),
        Detail(title: "Infinite", backdropPath: "/tUwgWj9EUK70qqkIlkwzMejc9wJ.jpg", posterPath: "/niw2AKHz6XmwiRMLWaoyAOAti0G.jpg"),
        Detail(title: "Don't Breathe 2", backdropPath: "/pUc51UUQb1lMLVVkDCaZVsCo37U.jpg", posterPath: "/hRMfgGFRAZIlvwVWy8DYJdLTpvN.jpg"),
        Detail(title: "The Suicide Squad", backdropPath: "/jlGmlFOcfo8n5tURmhC7YVd4Iyy.jpg", posterPath: "/kb4s0ML0iVZlG6wAKbbs9NAm6X.jpg"),
        Detail(title: "Snake Eyes: G.I. Joe Origins", backdropPath: "/aO9Nnv9GdwiPdkNO79TISlQ5bbG.jpg", posterPath: "/uIXF0sQGXOxQhbaEaKOi2VYlIL0.jpg")
    ]
}
