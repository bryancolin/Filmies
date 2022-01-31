//
//  String+Extension.swift
//  Filmies
//
//  Created by bryan colin on 7/31/21.
//

import Foundation

extension String {
    
    var wordCount: Int {
        let regex = try? NSRegularExpression(pattern: "\\w+")
        return regex?.numberOfMatches(in: self, range: NSRange(location: 0, length: self.utf16.count)) ?? 0
    }
    
    func toDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        return formatter.date(from: self) ?? Date()
    }
}
