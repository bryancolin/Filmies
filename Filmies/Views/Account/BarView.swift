//
//  BarView.swift
//  Filmies
//
//  Created by bryan colin on 7/30/21.
//

import SwiftUI

struct BarView: View {
    
    var title: String
    var width: CGFloat
    var height: CGFloat
    
    @State private var progress: CGFloat = 0
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 200)
                    .foregroundColor(Color.black.opacity(0.3))
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: progress * 200)
                    .foregroundColor(Color(K.BrandColors.pink))
                    .animation(.interpolatingSpring(mass: 1, stiffness: 100, damping: 17.5, initialVelocity: 0).speed(0.5))
                    .onAppear {
                        progress += (height < 6 ? (height/6) : 1)
                    }
                    .drawingGroup()
            }
            .frame(width: width)
            
            Text(title.prefix(1))
                .foregroundColor(.white)
        }
    }
}

