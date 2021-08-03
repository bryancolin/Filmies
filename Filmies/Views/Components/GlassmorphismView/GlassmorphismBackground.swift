//
//  GlassmorphismBackground.swift
//  Filmies
//
//  Created by bryan colin on 8/3/21.
//

import SwiftUI

struct GlassmorphismBackground: View {
    
    var type: Direction = .left
    var circleColors: [Color]
    var backgroundColors: [Color]
    
    var body: some View {
        LinearGradient (gradient: Gradient(colors: backgroundColors), startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
        
        GeometryReader { proxy in
            let width = (type == .left ? -1 : 1) * proxy.size.width
            let height = proxy.size.height
            
            BlurCircle(color: circleColors[0], paddingNumber: 50, offsetX: width/2, offsetY: -height/4)
            BlurCircle(color: circleColors[1], paddingNumber: 25, offsetX: -width/2.2)
            BlurCircle(color: circleColors[2], paddingNumber: 50, offsetX: width/2.1, offsetY: height/2)
            
            Color.black.opacity(0.3).ignoresSafeArea()
        }
    }
}

struct GlassmorphismBackground_Previews: PreviewProvider {
    static var previews: some View {
        GlassmorphismBackground(type: .left, circleColors: [Color(K.BrandColors.blue), Color(K.BrandColors.pink), Color(K.BrandColors.purple)], backgroundColors: [Color(K.BrandColors.purple), Color(K.BrandColors.blue)])
    }
}
