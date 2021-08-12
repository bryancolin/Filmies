//
//  CustomScrollView.swift
//  Filmies
//
//  Created by bryan colin on 8/12/21.
//

import SwiftUI

struct CustomScrollView<Content>: View where Content: View {
    
    let content: () -> Content
    
    @State var scrollViewOffset: CGFloat = 0
    @State var startOffset: CGFloat = 0
    @State var isScrollToTop = false
    
    init(@ViewBuilder _ content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        ScrollViewReader { proxyReader in
            ScrollView(.vertical, showsIndicators: false) {
                content()
                    .id("SCROLL_TO_TOP")
                    .overlay(
                        GeometryReader { proxy -> Color in
                            DispatchQueue.main.async {
                                let offset = proxy.frame(in:. global).minY
                                
                                if startOffset == 0 {
                                    self.startOffset = offset
                                }
                                
                                self.scrollViewOffset = offset - startOffset
                            }
                            
                            return Color.clear
                        },
                        alignment: .top
                    )
            }
            .overlay(
                Button(action: {
                    withAnimation(.linear(duration:  0.3)) {
                        isScrollToTop = true
                        proxyReader.scrollTo("SCROLL_TO_TOP", anchor: .top)
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        isScrollToTop = false
                    }
                }) {
                    Image(systemName: "arrow.up")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                        .padding()
                        .background(Color(K.BrandColors.pink))
                        .clipShape(Circle())
                }
                .buttonStyle(BorderlessButtonStyle())
                .padding(.trailing)
                .padding(.bottom, getSafeArea().bottom == 0 ? 12 : 0)
                .opacity(-scrollViewOffset > 450 ? 1 : 0)
                .animation(.easeInOut)
                .disabled(isScrollToTop),
                alignment: .bottomTrailing
            )
        }
        .foregroundColor(.white)
    }
}
