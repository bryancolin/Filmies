//
//  IconButton.swift
//  Filmies
//
//  Created by bryan colin on 9/28/21.
//

import SwiftUI

struct IconButton: View {
    
    //MARK: - PROPERTIES
    
    let title: String
    let action: () -> Void
    
    //MARK: - BODY
    
    var body: some View {
        Button(action: {
            action()
        }) {
            Image(systemName: title)
                .font(.system(size: 20))
        }
    }
}

//MARK: - PREVIEW

struct IconButton_Previews: PreviewProvider {
    static var previews: some View {
        IconButton(title: "xmark", action: {})
    }
}
