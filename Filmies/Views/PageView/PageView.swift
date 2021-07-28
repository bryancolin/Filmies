//
//  PageView.swift
//  Landmarks
//
//  Created by bryan colin on 7/5/21.
//  Copyright © 2021 Apple. All rights reserved.
//

import SwiftUI

struct PageView<Page: View>: View {
    
    var pages: [Page]
    var alignment: Alignment
    @State private var currentPage = 0
    
    var body: some View {
        ZStack(alignment: alignment) {
            PageViewController(pages: pages, currentPage: $currentPage)
            PageControl(numberOfPages: pages.count, currentpage: $currentPage)
                .frame(width: CGFloat(pages.count * 18))
                .padding(.trailing)
        }
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView(pages: [Color.black, Color.orange], alignment: .topTrailing)
            .aspectRatio(3 / 2, contentMode: .fit)
    }
}
