//
//  View+Extension.swift
//  Filmies
//
//  Created by bryan colin on 8/12/21.
//

import Foundation
import SwiftUI

extension View {
    
    func placeholder<Content: View>(when shouldShow: Bool, alignment: Alignment = .leading, @ViewBuilder placeholder: () -> Content) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
