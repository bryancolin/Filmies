//
//  TabBarButton.swift
//  Filmies
//
//  Created by bryan colin on 7/21/21.
//

import SwiftUI

struct TabBarButton: View {
    
    //MARK: - PROPERTIES
    
    var index: Int
    var image: Tab
    @Binding var selectedTab: Tab
    @Binding var tabPoints: [CGFloat]
    
    //MARK: - BODY
    
    var body: some View {
        GeometryReader { reader in
            let midX = reader.frame(in: .global).midX
            
            Button(action: {
                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.5, blendDuration: 0.5)) {
                    selectedTab = image
                }
            }) {
                Image(systemName: "\(image.rawValue)\(selectedTab == image ? ".fill" : "")")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.pink)
                    .offset(y: selectedTab == image ? -10 : 0)
                    .animation(.spring(response: 0.3, dampingFraction: 0.7), value: selectedTab)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onAppear {
                if tabPoints.indices.contains(index) {
                    tabPoints[index] = midX
                }
            }
        }
        .frame(height: 60)
    }
}
