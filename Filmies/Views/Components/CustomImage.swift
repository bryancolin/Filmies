//
//  CustomImage.swift
//  Filmies
//
//  Created by bryan colin on 7/20/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct CustomImage: View {
    
    //MARK: - PROPERTIES
    
    var urlPath: String?
    var placeholder: String = ""
    var ratio: ContentMode = .fit
    
    private var fullName: [String] {
        return placeholder.components(separatedBy: " ")
    }
    
    //MARK: - BODY
    
    var body: some View {
        if let path = urlPath, !path.isEmpty {
            let url = URL(string: "https://image.tmdb.org/t/p/w500" + path)
            webImage(with: url)
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
    
    // MARK: - FUNCTIONS
    
    @ViewBuilder
    func asyncImage(with url: URL?) -> some View {
        AsyncImage(url: url) { image in
            image.resizable()
        } placeholder: {
            Color.white.opacity(0.2)
        }
        .aspectRatio(2/3, contentMode: ratio)
    }
    
    @ViewBuilder
    func webImage(with url: URL?) -> some View {
        WebImage(url: url)
            .resizable()
            .aspectRatio(contentMode: ratio)
    }
}

//MARK: - PREVIEW

struct CustomImage_Previews: PreviewProvider {
    static var previews: some View {
        CustomImage(urlPath: "/e1mjopzAS2KNsvpbpahQ1a6SkSn.jpg")
    }
}


