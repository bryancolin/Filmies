//
//  ChartTab.swift
//  Filmies
//
//  Created by bryan colin on 8/8/21.
//

import SwiftUI

struct ChartTab: View {
    
    var titles: [String]
    @Binding var selectedIndex: Int
    
    var body: some View {
        HStack(alignment: .center) {
            ForEach(0..<titles.count) { index in
                VStack(spacing: 0) {
                    UnderlineText(title: titles[index], id: index, selectedIndex: $selectedIndex)
                }
            }
        }
        .padding()
    }
}
struct ChartTab_Previews: PreviewProvider {
    static var previews: some View {
        ChartTab(titles: ["One", "Two"], selectedIndex: .constant(0))
    }
}
