//
//  FilmDescriptions.swift
//  Filmies
//
//  Created by bryan colin on 8/5/21.
//

import SwiftUI

struct FilmDescriptions: View {
    
    let date, duration, rate: String
    
    var body: some View {
        
        GeometryReader { geometry in
            let width = geometry.size.width / 3.5
            
            HStack(alignment: .center) {
                // Rate
                VStack(alignment: .center) {
                    Spacer()
                    HStack {
                        Text(rate)
                        Image(systemName: "star.fill").font(.caption2)
                    }
                    Spacer()
                    Text("Rating").font(.caption)
                }
                .frame(width: width)
                
                Spacer()
                Rectangle().frame(width: 1)
                Spacer()
                
                // Duration
                VStack(alignment: .center) {
                    Spacer()
                    Text(duration)
                    Spacer()
                    Text("Duration").font(.caption)
                }
                .frame(width: width)

                Spacer()
                Rectangle().frame(width: 1)
                Spacer()

                // Release Date
                VStack(alignment: .center) {
                    Spacer()
                    Text(date)
                    Spacer()
                    Text("Release Date").font(.caption)
                }
                .frame(width: width)
            }
            .font(.headline)
            .lineLimit(2)
            .minimumScaleFactor(0.5)
            .multilineTextAlignment(.center)
        }
        .frame(height: 80)
    }
}

struct FilmDescriptions_Previews: PreviewProvider {
    static var previews: some View {
        FilmDescriptions(date: "10/06/2000", duration: "2h", rate: "7.9")
    }
}
