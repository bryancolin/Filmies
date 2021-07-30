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
    @State private var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 200)
                    .foregroundColor(Color.white.opacity(0.1))
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: progress)
                    .foregroundColor(Color(K.BrandColors.pink))
                    .animation(.linear)
                    .onReceive(timer, perform: { _ in
                        if progress < (height/6*200) {
                            progress += 10
                        }
                    })
            }
            .frame(width: width)
            
            Text(title.prefix(1))
                .foregroundColor(.white)
        }
    }
}

