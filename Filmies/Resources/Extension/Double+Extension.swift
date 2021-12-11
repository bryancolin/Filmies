//
//  Double+Extension.swift
//  Filmies
//
//  Created by bryan colin on 7/30/21.
//

import Foundation

extension Double {
    
    func toDate() -> Date {
        return NSDate(timeIntervalSince1970: self) as Date
    }
    
    func toString() -> String {
        return String(self)
    }
}
