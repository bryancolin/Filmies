//
//  LargeTitle.swift
//  Filmies
//
//  Created by bryan colin on 7/28/21.
//

import SwiftUI

struct TitleComponent<Content>: View where Content : View {
    
    //MARK: - PROPERTIES
    
    var name: String
    var color: Color
    var type: Font
    var weight: Font.Weight
    let content: () -> Content
    
    init(name: String, color: Color, type: Font, weight: Font.Weight, @ViewBuilder _ content: @escaping () -> Content) {
        self.name = name
        self.color = color
        self.type = type
        self.weight = weight
        self.content = content
    }
    
    //MARK: - BODY
    
    var body: some View {
        HStack {
            // Title
            Text(name)
                .font(type)
                .fontWeight(weight)
                .foregroundColor(color)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
            
            Spacer()
            
            content()
        }
        .padding()
    }
}
