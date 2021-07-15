//
//  RoundedText.swift
//  Filmies
//
//  Created by bryan colin on 7/15/21.
//

import SwiftUI

struct RoundedText: View {
    
    var titles: [String]
    @Binding var index: Int
    
    var body: some View {
        ForEach(0..<titles.count) { value in
            Text(titles[value])
                .font(.system(size: 15))
                .fontWeight(.bold)
                .padding(.vertical, 6)
                .padding(.horizontal, 20)
                .foregroundColor(value == index ? Color("BrandPink") : .white)
                .background(Color.white.opacity(value == index ? 1 : 0))
                .clipShape(Capsule())
                .onTapGesture {
                    if index < titles.count { 
                        index = value
                    }
                }
        }
    }
}
