//
//  UnderLineText.swift
//  Filmies
//
//  Created by bryan colin on 8/8/21.
//

import SwiftUI

struct UnderlineText: View {
    
    //MARK: - PROPERTIES
    
    var title: String
    var id: Int = 0
    @Binding var selectedIndex: Int
    
    var animation: Namespace.ID
    
    //MARK: - BODY
    
    var body: some View {
        Button(action: {
            selectedIndex = id
        }) {
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.caption2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .opacity(selectedIndex == id ? 1 : 0.5)
                
                
                if selectedIndex == id {
                    Capsule()
                        .foregroundColor(.white)
                        .frame(height: 4)
                        .padding(.trailing)
                        .matchedGeometryEffect(id: "text", in: animation)
                }
            }
            .padding(.horizontal, 5)
            .padding(.trailing, 10)
        }
    }
}

//MARK: - PREVIEW

struct UnderlineText_Previews: PreviewProvider {
    @Namespace static var animation
    
    static var previews: some View {
        UnderlineText(title: "Text", id: 0, selectedIndex: .constant(0), animation: animation)
    }
}
