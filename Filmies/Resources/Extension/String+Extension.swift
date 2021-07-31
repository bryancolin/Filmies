//
//  String+Extension.swift
//  Filmies
//
//  Created by bryan colin on 7/31/21.
//

import Foundation

extension String {
    
    func toDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        return formatter.date(from: self) ?? Date()
    }
}
