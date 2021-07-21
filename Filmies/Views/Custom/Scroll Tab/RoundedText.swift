//
//  RoundedText.swift
//  Filmies
//
//  Created by bryan colin on 7/15/21.
//

import SwiftUI

struct RoundedText: View {
    
    var titles: [String]
    @Binding var index: Int
    var color: CustomColor = .primary
    
    var body: some View {
        let firstColor = color == .primary ? Color(K.BrandColors.pink) : Color.white
        let secondColor = color == .primary ? Color.white : Color(K.BrandColors.pink)
        
        return ForEach(0..<titles.count) { value in
            Text(titles[value])
                .font(.system(size: 15))
                .fontWeight(.bold)
                .padding(.vertical, 6)
                .padding(.horizontal, 20)
                .foregroundColor(color == .primary ? (value == index ? firstColor : secondColor) : firstColor)
                .background(color == .primary ? secondColor.opacity(value == index ? 1 : 0) : firstColor.opacity(value == index ? 0.32 : 0))
                .clipShape(Capsule())
                .onTapGesture {
                    if index < titles.count { 
                        index = value
                    }
                }
        }
    }
}
