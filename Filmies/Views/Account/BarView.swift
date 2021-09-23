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
    @Binding var height: CGFloat
    
    private let defaultHeight: CGFloat = 200
    
    @State private var progress: CGFloat = 0
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                Capsule()
                    .frame(height: defaultHeight)
                    .foregroundColor(Color.black.opacity(0.3))
                
                Capsule()
                    .frame(height: progress * defaultHeight)
                    .foregroundColor(Color(K.BrandColors.pink))
                    .animation(.interpolatingSpring(mass: 1, stiffness: 100, damping: 17.5, initialVelocity: 0).speed(0.5), value: progress)
                    .onChange(of: height) { newValue in
                        updateProgress()
                    }
                    .onAppear {
                        updateProgress()
                    }
                    .drawingGroup()
            }
            .frame(width: width)
            
            Text(title.prefix(1))
                .foregroundColor(.white)
        }
    }
    
    func updateProgress() {
        progress = 0
        let h = height
        progress += (h < 6 ? (h/6) : 1)
    }
}

