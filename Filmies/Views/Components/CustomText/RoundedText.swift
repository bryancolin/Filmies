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
    
    var animation: Namespace.ID
    
    var body: some View {
        let firstColor = color == .primary ? Color(K.BrandColors.pink) : Color.white
        let secondColor = color == .primary ? Color.white : Color(K.BrandColors.pink)
        
        Button(action: {
            selectedIndex = id
        }) {
            Text(title)
                .font(.caption2)
                .fontWeight(.bold)
                .padding(.vertical, 6)
                .padding(.horizontal, 20)
                .foregroundColor(color == .primary ? (id == selectedIndex ? firstColor : secondColor) : firstColor)
                .background(
                    Capsule()
                        .foregroundColor(color == .primary ? secondColor.opacity(id == selectedIndex ? 1 : 0) : firstColor.opacity(id == selectedIndex ? 0.32 : 0))
                )
        }
    }
}
