//
//  LargeTitle.swift
//  Filmies
//
//  Created by bryan colin on 7/28/21.
//

import SwiftUI

struct TitleComponent<FirstContent, SecondContent>: View where FirstContent : View, SecondContent : View {
    
    var name: String
    var color: Color
    var type: Font
    var weight: Font.Weight
    let firstContent: () -> FirstContent
    let secondContent: () -> SecondContent
    
    init(name: String, color: Color, type: Font, weight: Font.Weight, @ViewBuilder firstContent: @escaping () -> FirstContent, @ViewBuilder secondContent: @escaping () -> SecondContent) {
        self.name = name
        self.color = color
        self.type = type
        self.weight = weight
        self.firstContent = firstContent
        self.secondContent = secondContent
    }
    
    var body: some View {
        HStack {
            // Title
            Text(name)
                .font(type)
                .fontWeight(weight)
                .foregroundColor(color)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
            
            firstContent()
            
            Spacer()
            
            secondContent()
        }
        .padding()
    }
}
