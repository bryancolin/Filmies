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
                ForEach(0..<titles.count) {
                    RoundedText(title: titles[$0], id: $0, selectedIndex: $selectedIndex, color: color)
                }
            }
            .padding(.horizontal)
        }
    }
}

