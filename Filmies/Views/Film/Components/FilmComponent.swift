//
//  MovieComponent.swift
//  Filmies
//
//  Created by bryan colin on 8/2/21.
//

import SwiftUI

struct FilmComponent<Content>: View where Content : View {
    
    //MARK: - PROPERTIES
    
    @Namespace var animation
    
    var title: String
    let content: () -> Content
    
    init(title: String, @ViewBuilder _ content: @escaping () -> Content) {
        self.title = title
        self.content = content
    }
    
    //MARK: - BODY
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // TITLE
            HStack {
                RoundedText(title: title, selectedIndex: .constant(0), color: .secondary, animation: animation)
                Spacer()
            }
            
            // BODY
            ScrollView(showsIndicators: false) {
                content()
            }
        } //: VSTACK
        .foregroundColor(.white)
        .padding()
    }
}
