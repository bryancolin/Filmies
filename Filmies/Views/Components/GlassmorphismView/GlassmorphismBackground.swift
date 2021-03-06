//
//  GlassmorphismBackground.swift
//  Filmies
//
//  Created by bryan colin on 8/3/21.
//

import SwiftUI

struct GlassmorphismBackground: View {
    
    var type: Direction = .left
    @Binding var circleColors: [Color]
    var backgroundColors: [Color]
    var blurRadius: CGFloat = 10
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: backgroundColors), startPoint: .top, endPoint: .bottom)
            
            GeometryReader { geometry in
                let width = (type == .left ? -1 : 1) * geometry.size.width
                let height = geometry.size.height
                
                BlurCircle(color: circleColors[0], paddingNumber: 50, offsetX: width/2, offsetY: -height/4, blurRadius: blurRadius)
                BlurCircle(color: circleColors[1], paddingNumber: 25, offsetX: -width/2.2, blurRadius: blurRadius)
                BlurCircle(color: circleColors[2], paddingNumber: 50, offsetX: width/2.1, offsetY: height/2, blurRadius: blurRadius)
                
                Color.black.opacity(0.3)
            }
        }
        .ignoresSafeArea()
    }
}

struct GlassmorphismBackground_Previews: PreviewProvider {
    static var previews: some View {
        GlassmorphismBackground(type: .left, circleColors: .constant([Color(K.BrandColors.blue), Color(K.BrandColors.pink), Color(K.BrandColors.purple)]), backgroundColors: [Color(K.BrandColors.purple), Color(K.BrandColors.blue)])
    }
}
