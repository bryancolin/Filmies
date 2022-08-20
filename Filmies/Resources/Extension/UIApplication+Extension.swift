//
//  UIApplication+Extension.swift
//  Filmies
//
//  Created by bryan colin on 20/08/22.
//

import UIKit

extension UIApplication {
    
    func isTopSafeAreaAvailable() -> Bool {
        return self.keyWindow?.safeAreaInsets.top != 20
    }
}
