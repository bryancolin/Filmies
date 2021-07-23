//
//  TabBarButton.swift
//  Filmies
//
//  Created by bryan colin on 7/21/21.
//

import SwiftUI

struct TabBarButton: View {
    
    var image: Tab
    @Binding var selectedTab: Tab
    @Binding var tabPoints: [CGFloat]
    
    var body: some View {
        GeometryReader{ reader -> AnyView in
            
            let midX = reader.frame(in: .global).midX
            
            DispatchQueue.main.async {
                if tabPoints.count <= 4 {
                    tabPoints.append(midX)
                }
            }
            
            return AnyView (
                Button(action: {
                    withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.5, blendDuration: 0.5)) {
                        selectedTab = image
                    }
                }, label: {
                    Image(systemName: "\(image.rawValue)\(selectedTab == image ? ".fill" : "")")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(Color(K.BrandColors.pink))
                        .offset(y: selectedTab == image ? -10 : 0)
                })
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            )
        }
        .frame(height: 60)
    }
}
