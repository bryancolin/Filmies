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
                .foregroundColor(.white)
            
            Spacer()
            
            VStack(alignment: .trailing) {
                if !details.isEmpty {
                    ForEach(0..<5) { index in
                        if index < details.count {
                            Text(details[index])
                                .foregroundColor(.white)
                                .multilineTextAlignment(.trailing)
                                .padding(.bottom, 1)
                        }
                    }
                } else {
                    Text("-")
                        .foregroundColor(.white)
                        .multilineTextAlignment(.trailing)
                        .padding(.bottom, 1)
                }
            }
        }
    }
}
