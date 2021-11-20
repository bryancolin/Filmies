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
    
    private var scrollId = "SCROLL_TO_TOP"
    
    init(@ViewBuilder _ content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        ScrollViewReader { proxyReader in
            ScrollView(.vertical, showsIndicators: false) {
                content()
                    .id(scrollId)
                    .overlay(alignment: .top) {
                        GeometryReader { proxy -> Color in
                            DispatchQueue.main.async {
                                let offset = proxy.frame(in:. global).minY
                                
                                if startOffset == 0 {
                                    self.startOffset = offset
                                }
                                
                                self.scrollViewOffset = offset - startOffset
                            }
                            return Color.clear
                        }
                    }
            }
            .overlay(alignment: .bottomTrailing) {
                IconButton(title: "arrow.up") {
                    withAnimation(.linear(duration:  0.3)) {
                        isScrollToTop = true
                        proxyReader.scrollTo(scrollId, anchor: .top)
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        isScrollToTop = false
                    }
                }
                .padding()
                .background(Color(K.BrandColors.pink))
                .clipShape(Circle())
                .buttonStyle(BorderlessButtonStyle())
                .padding()
                .opacity(-scrollViewOffset > 450 ? 1 : 0)
                .animation(.easeInOut, value: scrollViewOffset)
                .disabled(isScrollToTop)
            }
        }
        .foregroundColor(.white)
    }
}
