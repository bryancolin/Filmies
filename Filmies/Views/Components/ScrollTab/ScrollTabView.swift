//
//  ScrollTab.swift
//  Filmies
//
//  Created by bryan colin on 7/15/21.
//

import SwiftUI

struct ScrollTabView: View {
    
    //MARK: - PROPERTIES
    
    @Namespace var animation
    
    var titles: [String]
    @Binding var selectedIndex: Int
    var color: CustomColor = .primary
    
    //MARK: - BODY
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<titles.count) {
                    UnderlineText(title: titles[$0], id: $0, selectedIndex: $selectedIndex, animation: animation)
                } //: LOOP
            } //: HSTACK
            .padding(.horizontal)
        } //: SCROLL VIEW
    }
}

//MARK: - PREVIEW

struct ScrollTabView_Previews: PreviewProvider {
    @Namespace static var animation
    
    static var previews: some View {
        ScrollTabView(titles: ["", ""], selectedIndex: .constant(0))
    }
}

