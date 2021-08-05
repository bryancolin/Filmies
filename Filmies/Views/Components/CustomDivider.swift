//
//  CustomDivider.swift
//  Filmies
//
//  Created by bryan colin on 7/24/21.
//

import SwiftUI

struct CustomDivider: View {
    let color: Color = .gray
    let height: CGFloat = 2
    
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: height)
            .edgesIgnoringSafeArea(.horizontal)
    }
}

struct CustomDivider_Previews: PreviewProvider {
    static var previews: some View {
        CustomDivider()
    }
}
