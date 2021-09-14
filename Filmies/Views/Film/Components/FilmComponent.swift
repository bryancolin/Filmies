//
//  MovieComponent.swift
//  Filmies
//
//  Created by bryan colin on 8/2/21.
//

import SwiftUI

struct FilmComponent<Content>: View where Content : View {
    
    var title: String
    let content: () -> Content
    
    init(title: String, @ViewBuilder _ content: @escaping () -> Content) {
        self.title = title
        self.content = content
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Title
            HStack {
                RoundedText(title: title, selectedIndex: .constant(0), color: .secondary)
                Spacer()
            }
            
            // Body
            ScrollView(showsIndicators: false) {
                content()
            }
        }
        .foregroundColor(.white)
        .padding()
    }
}
