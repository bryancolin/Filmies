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
        WebImage(url: URL(string: urlString))
            .resizable()
            .aspectRatio(contentMode: .fill)
    }
}
