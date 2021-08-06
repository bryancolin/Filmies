//
//  VerticalComponent.swift
//  Filmies
//
//  Created by bryan colin on 8/2/21.
//

import SwiftUI

struct VerticalComponent: View {
    
    var title: String
    var urls: [String]
    var details: [String]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            
            CustomDivider()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 10) {
                    ForEach(0..<5) { index in
                        if index < details.count {
                            VStack(alignment: .leading) {
                                CustomImage(urlString: urls[index], placeholder: "user")
                                    .frame(width: 75, height: 75)
                                    .cornerRadius(50)
                                
                                Text(details[index])
                                    .foregroundColor(.white)
                                    .frame(width: 75)
                                    .font(.caption)
                                    .lineLimit(2)
                                    .minimumScaleFactor(0.5)
                            }
                        }
                    }
                }
            }
        }
    }
}
