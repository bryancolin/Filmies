//
//  BarView.swift
//  Filmies
//
//  Created by bryan colin on 7/30/21.
//

import SwiftUI

struct BarView: View {
    
    //MARK: - PROPERTIES
    
    var title: String
    var width: CGFloat
    @Binding var height: CGFloat
    @Binding var value: String
    
    private let defaultHeight: CGFloat = 200
    
    @State private var progress: CGFloat = 0
    @State private var showValue: Bool = false
    
    //MARK: - BODY
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                
                // MARK: - PLACEHOLDER BAR
                Capsule()
                    .frame(height: defaultHeight)
                    .foregroundColor(Color.black.opacity(0.3))
                
                // MARK: - DEFAULT BAR
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
                
                // MARK: - INNER BAR
                Capsule()
                    .frame(height: defaultHeight/6)
                    .foregroundColor(.white)
                    .overlay(alignment: .bottom) {
                        Text(value)
                            .foregroundColor(.black)
                            .font(.caption2)
                            .fontWeight(.semibold)
                            .padding(.bottom, 10)
                            .multilineTextAlignment(.center)
                    }
                    .onChange(of: value) { newValue in
                        showValue = false
                    }
                    .opacity(showValue ? 1 : 0)
                    .transition(.opacity)
            } //: ZSTACK
            .frame(width: width)
            .onTapGesture {
                withAnimation(.spring()) {
                    if !progress.isZero {
                        showValue.toggle()
                    }
                }
            }
            
            Text(title.prefix(1))
                .foregroundColor(.white)
        } //: VSTACK
    }
    
    //MARK: - FUNCTIONS
    
    func updateProgress() {
        progress = 0
        let h = height
        progress += (h < 6 ? (h/6) : 1)
    }
}

//MARK: - PREVIEW

struct BarView_Previews: PreviewProvider {
    static var previews: some View {
        BarView(title: "M", width: 50, height: .constant(50), value: .constant("1h"))
            .environmentObject(ModelData())
    }
}
