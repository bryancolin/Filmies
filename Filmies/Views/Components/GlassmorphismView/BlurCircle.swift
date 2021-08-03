//
//  BlurCircle.swift
//  Filmies
//
//  Created by bryan colin on 8/3/21.
//

import SwiftUI

struct BlurCircle: View {
    
    var color: Color
    var paddingNumber: CGFloat
    var offsetX: CGFloat = 0
    var offsetY: CGFloat = 0
    var blurRadius: CGFloat = 10
    var shadowRadius: CGFloat = 100
    
    var body: some View {
        Circle()
            .foregroundColor(color)
            .padding(paddingNumber)
            .blur(radius: blurRadius)
            .shadow(radius: shadowRadius)
            .offset(x: offsetX, y: offsetY)
    }
}

struct BlurCircle_Previews: PreviewProvider {
    static var previews: some View {
        BlurCircle(color: Color(K.BrandColors.pink), paddingNumber: 0)
    }
}
