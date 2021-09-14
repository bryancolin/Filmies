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
    
    func getWeek(index: Int) -> Bool {
        return Calendar.current.isDateInWeekOf(self, weekOfYear: index)
    }
    
    func isThisWeek() -> Bool {
        return Calendar.current.isDateInThisWeek(self)
    }
    
    func isLastWeek() -> Bool {
        return Calendar.current.isDateInLastWeek(self)
    }
}
