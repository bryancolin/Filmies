//
//  Calendar+Extension.swift
//  Filmies
//
//  Created by bryan colin on 8/8/21.
//

import Foundation

extension Calendar {
    
    func intervalOfWeek(for date: Date) -> DateInterval? {
        return dateInterval(of: .weekOfYear, for: date)
    }
    
    func startOfWeek(weekOfYear: Int) -> Date? {
        guard let week = self.date(byAdding: DateComponents(weekOfYear: weekOfYear), to: Date()) else { return nil }
        return intervalOfWeek(for: week)?.start
    }
    
    func endOfWeek(weekOfYear: Int) -> Date? {
        guard let week = self.date(byAdding: DateComponents(weekOfYear: weekOfYear), to: Date()) else { return nil }
        return intervalOfWeek(for: week)?.end
    }
    
    func isDateInWeekOf(_ date: Date, weekOfYear: Int) -> Bool {
        guard let week = self.date(byAdding: DateComponents(weekOfYear: weekOfYear), to: Date()) else { return false }
        return isDate(date, equalTo: week, toGranularity: .weekOfYear)
    }
    
    func isDateInThisWeek(_ date: Date) -> Bool {
        return isDate(date, equalTo: Date(), toGranularity: .weekOfYear)
    }
    
    func isDateInLastWeek(_ date: Date) -> Bool {
        guard let lastWeek = self.date(byAdding: DateComponents(weekOfYear: -1), to: Date()) else { return false }
        return isDate(date, equalTo: lastWeek, toGranularity: .weekOfYear)
    }
}
