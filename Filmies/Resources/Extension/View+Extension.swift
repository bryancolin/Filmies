//
//  View+Extension.swift
//  Filmies
//
//  Created by bryan colin on 8/12/21.
//

import Foundation
import SwiftUI

extension View {
    
    func getSafeArea() -> UIEdgeInsets {
        return UIApplication.shared.windows.first?.safeAreaInsets ?? UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
