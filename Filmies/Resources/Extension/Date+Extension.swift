//
//  Date+Extension.swift
//  Filmies
//
//  Created by bryan colin on 7/30/21.
//

import Foundation

extension Date {
    
    func toString(format: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func dateAndTimetoString(format: String = "yyyy-MM-dd HH:mm") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func fullDayName(format: String = "EEEE") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func isThisWeek() -> Bool {
        return Calendar.current.isDateInThisWeek(self)
    }
    
    func isLastWeek() -> Bool {
        return Calendar.current.isDateInLastWeek(self)
    }
}

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
