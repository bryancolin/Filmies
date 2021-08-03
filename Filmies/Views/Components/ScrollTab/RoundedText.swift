//
//  RoundedText.swift
//  Filmies
//
//  Created by bryan colin on 7/15/21.
//

import SwiftUI

struct RoundedText: View {
    
    var title: String
    var id: Int = 0
    @Binding var selectedIndex: Int
    var color: CustomColor = .primary
    
    var body: some View {
        let firstColor = color == .primary ? Color(K.BrandColors.pink) : Color.white
        let secondColor = color == .primary ? Color.white : Color(K.BrandColors.pink)
        
        Text(title)
            .font(.system(size: 15))
            .fontWeight(.bold)
            .padding(.vertical, 6)
            .padding(.horizontal, 20)
            .foregroundColor(color == .primary ? (id == selectedIndex ? firstColor : secondColor) : firstColor)
            .background(color == .primary ? secondColor.opacity(id == selectedIndex ? 1 : 0) : firstColor.opacity(id == selectedIndex ? 0.32 : 0))
            .clipShape(Capsule())
    }
}
