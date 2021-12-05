//
//  FilmDescriptions.swift
//  Filmies
//
//  Created by bryan colin on 8/5/21.
//

import SwiftUI

struct FilmDescriptions: View {
    
    //MARK: - PROPERTIES
    
    let date, duration, rate: String
    
    //MARK: - BODY
    
    var body: some View {
        
        GeometryReader { geometry in
            let width = geometry.size.width / 3.5
            
            HStack(alignment: .center) {
                // RATE
                VStack(alignment: .center) {
                    Spacer()
                    HStack {
                        Text(rate)
                        Image(systemName: "star.fill").font(.caption2)
                    }
                    Spacer()
                    Text("Rating").font(.caption)
                } //: VSTACK
                .frame(width: width)
                
                Spacer()
                Rectangle().frame(width: 1)
                Spacer()
                
                // DURATION
                VStack(alignment: .center) {
                    Spacer()
                    Text(duration)
                    Spacer()
                    Text("Duration").font(.caption)
                } //: VSTACK
                .frame(width: width)

                Spacer()
                Rectangle().frame(width: 1)
                Spacer()

                // RELEASE DATE
                VStack(alignment: .center) {
                    Spacer()
                    Text(date)
                    Spacer()
                    Text("Release Date").font(.caption)
                } //: VSTACK
                .frame(width: width)
            } //: HSTACK
            .font(.headline)
            .lineLimit(2)
            .minimumScaleFactor(0.5)
            .multilineTextAlignment(.center)
        } // GEOMETRY READER
        .frame(height: 80)
    }
}

//MARK: - PREVIEW

struct FilmDescriptions_Previews: PreviewProvider {
    static var previews: some View {
        FilmDescriptions(date: "10/06/2000", duration: "2h", rate: "7.9")
    }
}
