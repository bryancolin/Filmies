//
//  HorizontalComponent.swift
//  Filmies
//
//  Created by bryan colin on 8/2/21.
//

import SwiftUI

struct HorizontalComponent: View {
    
    //MARK: - PROPERTIES
    
    var title: String
    var details: [String]
    
    //MARK: - BODY
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Text(!details.isEmpty ? details.joined(separator: "  ") : "-")
                    .multilineTextAlignment(.leading)
                    .lineSpacing(2)
                    .padding(.bottom, 1)
            } //: VSTACK
            .padding(.bottom, 5)
            
            Spacer()
        } //: HSTACK
    }
}

//MARK: - PREVIEW

struct HorizontalComponent_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalComponent(title: "Language", details: ["English", "Mandarin"])
            .environmentObject(ModelData())
    }
}
