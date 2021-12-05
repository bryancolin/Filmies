//
//  CustomDivider.swift
//  Filmies
//
//  Created by bryan colin on 7/24/21.
//

import SwiftUI

struct CustomDivider: View {
    
    //MARK: - PROPERTIES
    
    let color: Color = .gray
    let height: CGFloat = 2
    
    //MARK: - BODY
    
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: height)
            .edgesIgnoringSafeArea(.horizontal)
    }
}

//MARK: - PREVIEW

struct CustomDivider_Previews: PreviewProvider {
    static var previews: some View {
        CustomDivider()
    }
}
