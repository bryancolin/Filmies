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
    
    private var fullName: [String] {
        return placeholder.components(separatedBy: " ")
    }
    
    var body: some View {
        if !urlString.isEmpty {
            WebImage(url: URL(string: urlString))
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
