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
        HStack(alignment: .center) {
            Text(title)
                .fontWeight(.semibold)
            
            Spacer()
            
            VStack(alignment: .trailing) {
                if !details.isEmpty {
                    ForEach(0..<5) { index in
                        if index < details.count {
                            Text(details[index])
                        }
                    }
                } else {
                    Text("-")
                }
            }
            .font(.caption)
            .multilineTextAlignment(.trailing)
            .padding(.bottom, 1)
        }
        .padding(.bottom, 5)
    }
}
