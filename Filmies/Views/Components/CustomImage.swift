//
//  CustomImage.swift
//  Filmies
//
//  Created by bryan colin on 7/20/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct CustomImage: View {
    
    var urlPath: String?
    var placeholder: String = ""
    
    private var fullName: [String] {
        return placeholder.components(separatedBy: " ")
    }
    
    var body: some View {
        if let url = urlPath, !url.isEmpty {
            WebImage(url: URL(string: "https://image.tmdb.org/t/p/w500" + url))
                .resizable()
                .aspectRatio(contentMode: .fill)
        } else {
            ZStack {
                Color(K.BrandColors.darkBlue)
                
                if !placeholder.isEmpty {
                    if let firstName = fullName.first?.prefix(1), let lastName = fullName.last?.prefix(1) {
                        Text(firstName + lastName)
                    }
                }
            }
        }
    }
}
