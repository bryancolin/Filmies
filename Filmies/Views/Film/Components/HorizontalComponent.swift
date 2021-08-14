//
//  HorizontalComponent.swift
//  Filmies
//
//  Created by bryan colin on 8/2/21.
//

import SwiftUI

struct HorizontalComponent: View {
    
    var title: String
    var details: [String]
    
    var body: some View {
        HStack(alignment: .top) {
            Text(title)
                .fontWeight(.semibold)
            
            Spacer()
            
            VStack(alignment: .trailing) {
                if !details.isEmpty {
                    ForEach(0..<5) {
                        if $0 < details.count {
                            Text(details[$0])
                        }
                    }
                } else {
                    Text("-")
                }
            }
            .multilineTextAlignment(.trailing)
            .padding(.bottom, 1)
        }
        .padding(.bottom, 5)
    }
}
