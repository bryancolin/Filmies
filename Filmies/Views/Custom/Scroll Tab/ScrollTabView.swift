//
//  ScrollTab.swift
//  Filmies
//
//  Created by bryan colin on 7/15/21.
//

import SwiftUI

struct ScrollTabView: View {
    
    var titles: [String]
    @Binding var index: Int
    var color: CustomColor = .primary
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                RoundedText(titles: titles, index: $index, color: color)
                    .animation(.easeInOut)
            }
            .padding(.horizontal)
        }
    }
}
