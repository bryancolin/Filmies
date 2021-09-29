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

struct AnotherChartTab: View {
    
    var title: String
    @Binding var selectedIndex: Int
    
    var body: some View {
        HStack {
            IconButton(title: "chevron.left") {
                withAnimation {
                    selectedIndex -= 1
                }
            }
            
            Spacer()
            
            Text(title)
            
            Spacer()
            
            IconButton(title: "chevron.right") {
                withAnimation {
                    selectedIndex += 1
                }
            }
            .opacity(selectedIndex == 0 ? 0 : 1)
            .disabled(selectedIndex == 0 ? true : false)
            
        }
        .foregroundColor(.white)
        .padding()
    }
}
