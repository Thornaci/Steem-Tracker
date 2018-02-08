//
//  DateExtension.swift
//  SteemitApp
//
//  Created by Burak Tayfun on 1/8/18.
//  Copyright © 2018 Burak Tayfun. All rights reserved.
//

import Foundation

extension Date {
    static let iso8601Formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
    var timeWithiso8601: String {
        return Date.iso8601Formatter.string(from: self)
    }
    
    var dayOfYear: Int {
        return Calendar.current.ordinality(of: .day, in: .year, for: self)!
    }
    
    func getDateFromDay(day: Int) -> Date {
        let now = Date()
        let year = Calendar.current.ordinality(of: .year, in: .era, for: now)!
        let date = DateComponents(calendar: .current, year: year, day: day).date   //  "May 1, 2017, 12:00 AM"
        return date!
    }
    
    func dateWithFormat(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
