//
//  KGNDate.swift
//  KGNDate
//
//  Created by David Keegan on 9/08/16.
//  Copyright (c) 2016 David Keegan. All rights reserved.
//

import Foundation

public enum DateFormatLength {
    case none
    case short
    case long
}

internal func _ordinal(_ value: Int) -> String {
    if value >= 11 && value <= 13 {
        return "th";
    }
    switch (value % 10) {
    case 1: return "st"
    case 2: return "nd"
    case 3: return "rd"
    default: return "th"
    }
}

extension Date {
    
    public func component(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
    
    public func add(_ component: Calendar.Component, _ value: Int = 1, calendar: Calendar = Calendar.current) -> Date {
        var dateComp = DateComponents()
        switch component {
        case .calendar: break
        case .day: dateComp.day = value
        case .era: dateComp.era = value
        case .hour: dateComp.hour = value
        case .minute: dateComp.minute = value
        case .month: dateComp.month = value
        case .nanosecond: dateComp.nanosecond = value
        case .quarter: dateComp.quarter = value
        case .second: dateComp.second = value
        case .timeZone: break
        case .weekOfMonth: dateComp.weekOfMonth = value
        case .weekOfYear: dateComp.weekOfYear = value
        case .weekday: dateComp.weekday = value
        case .weekdayOrdinal: dateComp.weekdayOrdinal = value
        case .year: dateComp.year = value
        case .yearForWeekOfYear: dateComp.yearForWeekOfYear = value
        }
        return calendar.date(byAdding: dateComp, to: self) ?? self
    }
    
    public func format(day: DateFormatLength = .long, month: DateFormatLength = .long, year: DateFormatLength = .long, calendar: Calendar = Calendar.current) -> String {
        let monthValue = self.component(.month, calendar: calendar)
        let dayValue = self.component(.day, calendar: calendar)
        let yearValue = self.component(.year, calendar: calendar)
        
        var dateString = ""
        switch month {
        case .none: break
        case .short: dateString += calendar.shortMonthSymbols[monthValue-1]
        case .long: dateString += calendar.monthSymbols[monthValue-1]
        }
        
        if day != .none && month != .none {
            dateString += " "
        }
        
        switch day {
        case .none: break
        case .short: dateString += "\(dayValue)"
        case .long: dateString += "\(dayValue)\(_ordinal(dayValue))"
        }
        
        switch year {
        case .none: break
        case .short: let shortYear = String("\(yearValue)".characters.suffix(2)); dateString += ", \(shortYear)"
        case .long: dateString += ", \(yearValue)"
        }
        
        return dateString
    }
    
    public func relativeFormat(calendar: Calendar = Calendar.current) -> String {
        let now = Date()
        
        // Today, Yesterday, Tomorrow
        if calendar.isDateInToday(self) {
            return "Today"
        } else if calendar.isDateInYesterday(self) {
            return "Yesterday"
        } else if calendar.isDateInTomorrow(self) {
            return "Tomorrow"
        }
        
        //let components = calendar.dateComponents([.day, .weekday, .month, .weekOfYear], from: self, to: Date())
        
        // TODO: handle weeks that cross the year
        // This week, last week, next week
        let weekday = self.component(.weekday, calendar: calendar)
        let nowWeekday = now.component(.weekday, calendar: calendar)
        let weekOfYear = self.component(.weekOfYear, calendar: calendar)
        let nowWeekOfYear = now.component(.weekOfYear, calendar: calendar)
        let weekOfYearDelta = nowWeekOfYear-weekOfYear
        if weekOfYearDelta == 0 {
            if weekday < nowWeekday {
                return "\(calendar.weekdaySymbols[weekday-1])"
            } else {
                return "This \(calendar.weekdaySymbols[weekday-1])"
            }
        } else if weekOfYearDelta == -1 {
            return "Last \(calendar.weekdaySymbols[weekday-1])"
        } else if weekOfYearDelta == 1 {
            return "Next \(calendar.weekdaySymbols[weekday-1])"
        }
        
        // TODO: handle weeks that cross the year
        let month = self.component(.month, calendar: calendar)
//        let nowMonth = now.component(.month, calendar: calendar)
//        let monthDelta = nowMonth-month
        if month <= 1 {
            return "This Month"
        }
        
        // X days ago
//        let day = self.component(.day, calendar: calendar)
//        let nowDay = now.component(.day, calendar: calendar)
        
        // X weeks ago
        // this month
        // last month
        // date format
        
        return self.format()
    }
    
}

//// May 17th
//Date().add(.day, 12).add(.month, 2).format(month: .short, day: .long, year: .none)
//
//Date().add(.day, -2).relativeFormat() // Tuesday
//Date().add(.day, 2).relativeFormat() // This Saturday
//Date().add(.weekOfYear, -1).relativeFormat() // Next Thursday
//Date().add(.weekOfYear, 1).relativeFormat() // Last Thursday
//
//// Today, Tomorrow, Yesterday, Last Tuesday
//// Today, Yesterday, This Week, Last Week, This Month, Last Month
