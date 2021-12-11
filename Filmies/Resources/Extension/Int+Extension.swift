//
//  Int+Extension.swift
//  Filmies
//
//  Created by bryan colin on 7/30/21.
//

import Foundation

extension Int {
    
    var hours: Int { self / 60 }
    
    var minutes: Int { self % 60 }
    
    func toTimeString() -> String {
        return (hours > 0 ? "\(hours)h " : "") + "\(minutes) m"
    }
}
