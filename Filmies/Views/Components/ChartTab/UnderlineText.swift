//
//  UnderLineText.swift
//  Filmies
//
//  Created by bryan colin on 8/8/21.
//

import SwiftUI

struct UnderlineText: View {
    
    var title: String
    var id: Int = 0
    @Binding var selectedIndex: Int
    
    var body: some View {
        Button(action: {
            selectedIndex = id
        }) {
            VStack(spacing: 0) {
                Text(title)
                    .foregroundColor(id == selectedIndex ? Color(K.BrandColors.pink) : .white)
                    .font(.caption2)
                
                Capsule()
                    .foregroundColor(.white)
                    .frame(height: id == selectedIndex ? 4 : 0)
            }
        }
    }
}


struct UnderLineText_Previews: PreviewProvider {
    static var previews: some View {
        UnderlineText(title: "One", selectedIndex: .constant(0))
    }
}
