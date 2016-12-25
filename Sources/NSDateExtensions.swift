//
//  NSDateExtensions.swift
//  EZSwiftExtensions
//
//  Created by Goktug Yilmaz on 15/07/15.
//  Copyright (c) 2015 Goktug Yilmaz. All rights reserved.
//
import UIKit

class DateFormatterCache {
    static let c = DateFormatterCache()
    
    var cachedFormatters = [String: NSDateFormatter]()
    
    func getFormatter(format: String) -> NSDateFormatter {
        if let formatter = cachedFormatters[format] {
            return formatter
        } else {
            let formatter = NSDateFormatter()
            formatter.dateFormat = format
            cachedFormatters[format] = formatter
            return formatter
        }
    }
}

extension NSDate {
    /// EZSE: Initializes NSDate from string and format
    public convenience init?(fromString string: String, format: String) {
        let formatter = DateFormatterCache.c.getFormatter(format)
        if let date = formatter.dateFromString(string) {
            self.init(timeInterval: 0, sinceDate: date)
        } else {
            self.init()
            return nil
        }
    }

    /// EZSE: Initializes NSDate from string returned from an http response, according to several RFCs
    public convenience init? (httpDateString: String) {
        if let rfc1123 = NSDate(fromString: httpDateString, format: "EEE',' dd' 'MMM' 'yyyy HH':'mm':'ss zzz") {
            self.init(timeInterval: 0, sinceDate: rfc1123)
            return
        }
        if let rfc850 = NSDate(fromString: httpDateString, format: "EEEE',' dd'-'MMM'-'yy HH':'mm':'ss z") {
            self.init(timeInterval: 0, sinceDate: rfc850)
            return
        }
        if let asctime =  NSDate(fromString: httpDateString, format: "EEE MMM d HH':'mm':'ss yyyy") {
            self.init(timeInterval: 0, sinceDate: asctime)
            return
        }
        //self.init()
        return nil
    }

    /// EZSE: Converts NSDate to String
    public func toString(dateStyle dateStyle: NSDateFormatterStyle = .MediumStyle, timeStyle: NSDateFormatterStyle = .MediumStyle) -> String {
        let formatter = NSDateFormatter()
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
        return formatter.stringFromDate(self)
    }

    /// EZSE: Converts NSDate to String, with format
    public func toString(format format: String) -> String {
        let formatter = DateFormatterCache.c.getFormatter(format)
        return formatter.stringFromDate(self)
    }

    /// EZSE: Calculates how many days passed from now to date
    public func daysInBetweenDate(date: NSDate) -> Double {
        var diff = self.timeIntervalSinceNow - date.timeIntervalSinceNow
        diff = fabs(diff/86400)
        return diff
    }

    /// EZSE: Calculates how many hours passed from now to date
    public func hoursInBetweenDate(date: NSDate) -> Double {
        var diff = self.timeIntervalSinceNow - date.timeIntervalSinceNow
        diff = fabs(diff/3600)
        return diff
    }

    /// EZSE: Calculates how many minutes passed from now to date
    public func minutesInBetweenDate(date: NSDate) -> Double {
        var diff = self.timeIntervalSinceNow - date.timeIntervalSinceNow
        diff = fabs(diff/60)
        return diff
    }

    /// EZSE: Calculates how many seconds passed from now to date
    public func secondsInBetweenDate(date: NSDate) -> Double {
        var diff = self.timeIntervalSinceNow - date.timeIntervalSinceNow
        diff = fabs(diff)
        return diff
    }

    /// EZSE: Easy creation of time passed String. Can be Years, Months, days, hours, minutes or seconds
    public func timePassed() -> String {
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Year, .Month, .Day, .Hour, .Minute, .Second], fromDate: self, toDate: date, options: [])
        var str: String

        if components.year >= 1 {
            components.year == 1 ? (str = "year") : (str = "years")
            return "\(components.year) \(str) ago"
        } else if components.month >= 1 {
            components.month == 1 ? (str = "month") : (str = "months")
            return "\(components.month) \(str) ago"
        } else if components.day >= 1 {
            components.day == 1 ? (str = "day") : (str = "days")
            return "\(components.day) \(str) ago"
        } else if components.hour >= 1 {
            components.hour == 1 ? (str = "hour") : (str = "hours")
            return "\(components.hour) \(str) ago"
        } else if components.minute >= 1 {
            components.minute == 1 ? (str = "minute") : (str = "minutes")
            return "\(components.minute) \(str) ago"
        } else if components.second == 0 {
            return "Just now"
        } else {
            return "\(components.second) seconds ago"
        }
    }
    
    public func midnight() -> NSDate {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Year, .Month, .Day], fromDate: self)
        return calendar.dateFromComponents(components)!
    }
    
    public func allDaysInSameWeek() -> [NSDate] {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Year, .Month, .WeekOfMonth], fromDate: self)
        
        var ret = [NSDate]()
        for weekDay in 1...7 {
            components.weekday = weekDay
            ret.append(calendar.dateFromComponents(components)!)
        }
        
        return ret
    }
    
    public func allDaysInSameMonth() -> [NSDate] {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Year, .Month], fromDate: self)
        
        var ret = [NSDate]()
        for day in 1...31 {
            components.day = day
            if let date = calendar.dateFromComponents(components) {
                ret.append(date)
            }
        }
        
        return ret
    }
    
    public func isSameWeek(date: NSDate) -> Bool {
        let calendar = NSCalendar.currentCalendar()
        return calendar.isDate(self, equalToDate: date, toUnitGranularity: .WeekOfYear)
    }
    
    public func isSameMonth(date: NSDate) -> Bool {
        let calendar = NSCalendar.currentCalendar()
        let c1 = calendar.components([.Year, .Month], fromDate: self)
        let c2 = calendar.components([.Year, .Month], fromDate: date)
        
        return c1 == c2
    }
    
    public func convertDateToTodayWithSameTime() -> NSDate {
        let calendar = NSCalendar.currentCalendar()
        let targetComponents = NSDateComponents.init()
        let todayComponents = calendar.components([.Year, .Month, .Day], fromDate: NSDate())
        let selfComponents = calendar.components([.Hour, .Minute, .Second], fromDate: self)
        targetComponents.year = todayComponents.year
        targetComponents.month = todayComponents.month
        targetComponents.day = todayComponents.day
        targetComponents.hour = selfComponents.hour
        targetComponents.minute = selfComponents.minute
        targetComponents.second = selfComponents.second
        
        return calendar.dateFromComponents(targetComponents)!
    }

}

extension NSDate: Comparable {}
 /// EZSE: Returns if dates are equal to each other
public func == (lhs: NSDate, rhs: NSDate) -> Bool {
  return lhs.isEqualToDate(rhs)
}
 /// EZSE: Returns if one date is smaller than the other
public func < (lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == .OrderedAscending
}

public func > (lhs: NSDate, rhs: NSDate) -> Bool {
  return lhs.compare(rhs) == .OrderedDescending
}
