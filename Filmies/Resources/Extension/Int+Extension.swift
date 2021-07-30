//
//  Int+Extension.swift
//  Filmies
//
//  Created by bryan colin on 7/30/21.
//

import Foundation

extension Int {
    
    func convert() -> String {
        let hours = self / 60
        let minutes = self % 60
        return String(hours > 0 ? "\(hours)h " : "") + "\(minutes)m"
    }
}
