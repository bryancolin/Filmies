//
//  ScrollTab.swift
//  Filmies
//
//  Created by bryan colin on 7/15/21.
//

import SwiftUI

struct ScrollTabView: View {
    
    var titles: [String]
    @Binding var selectedIndex: Int
    var color: CustomColor = .primary
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<titles.count) { index in
                    RoundedText(title: titles[index], id: index, selectedIndex: $selectedIndex, color: color)
                }
            }
            .padding(.horizontal)
        }
    }
}

