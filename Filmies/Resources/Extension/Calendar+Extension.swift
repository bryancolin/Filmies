//
//  Calendar+Extension.swift
//  Filmies
//
//  Created by bryan colin on 8/8/21.
//

import Foundation

extension Calendar {
    
    func isDateInThisWeek(_ date: Date) -> Bool {
        return isDate(date, equalTo: Date(), toGranularity: .weekOfYear)
    }
    
    func isDateInLastWeek(_ date: Date) -> Bool {
        guard let lastWeek = self.date(byAdding: DateComponents(weekOfYear: -1), to: Date()) else {
            return false
        }
        return isDate(date, equalTo: lastWeek, toGranularity: .weekOfYear)
    }
}
