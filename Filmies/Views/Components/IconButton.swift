//
//  IconButton.swift
//  Filmies
//
//  Created by bryan colin on 9/28/21.
//

import SwiftUI

struct IconButton: View {
    
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            Image(systemName: title)
        }
    }
}

struct IconButton_Previews: PreviewProvider {
    static var previews: some View {
        IconButton(title: "", action: {})
    }
}
