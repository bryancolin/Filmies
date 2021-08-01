//
//  CustomImage.swift
//  Filmies
//
//  Created by bryan colin on 7/20/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct CustomImage: View {
    
    var urlString: String
    var placeholder: String = ""
    
    var body: some View {
        if !urlString.isEmpty {
            WebImage(url: URL(string: urlString))
                .resizable()
                .aspectRatio(contentMode: .fill)
        } else {
            if !placeholder.isEmpty {
                Image(placeholder)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .opacity(0.5)
            } else {
                Color(K.BrandColors.darkBlue)
            }
        }
    }
}
