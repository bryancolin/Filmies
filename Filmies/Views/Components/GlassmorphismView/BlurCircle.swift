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
    
    @State private var isAppear = false
    
    var body: some View {
        Circle()
            .foregroundColor(color)
            .padding(paddingNumber)
            .blur(radius: blurRadius)
            .shadow(radius: shadowRadius)
            .offset(x: isAppear ? offsetX : 0,
                    y: offsetY)
            .animation(.interpolatingSpring(mass: 1, stiffness: 100, damping: 5, initialVelocity: 0))
            .onAppear {
                isAppear.toggle()
            }
            .drawingGroup()
    }
}

struct BlurCircle_Previews: PreviewProvider {
    static var previews: some View {
        BlurCircle(color: Color(K.BrandColors.pink), paddingNumber: 0)
    }
}
