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
    
    var body: some View {
        if !urlString.isEmpty {
            WebImage(url: URL(string: urlString))
                .resizable()
                .aspectRatio(contentMode: .fill)
        } else {
            Color(K.BrandColors.darkBlue)
//            Image("filmies_app_icon")
//                .resizable()
//                .aspectRatio(contentMode: .fill)
        }
    }
}
