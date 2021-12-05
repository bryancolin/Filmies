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
        HStack(alignment: .top) {
            Text(title)
                .fontWeight(.semibold)
            
            Spacer()
            
            VStack(alignment: .trailing) {
                if !details.isEmpty {
                    ForEach(0..<5) {
                        if $0 < details.count {
                            Text(details[$0])
                        }
                    }
                } else {
                    Text("-")
                }
            } //: VSTACK
            .multilineTextAlignment(.trailing)
            .padding(.bottom, 1)
        }
        .padding(.bottom, 5)
    } //: HSTACK
}

//MARK: - PREVIEW

struct HorizontalComponent_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalComponent(title: "Language", details: ["English", "Mandarin"])
            .environmentObject(ModelData())
    }
}
