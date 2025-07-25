//
//  Date+Extensions.swift
//  WeatherForecastApp
//
//  Created by Samuel Pinheiro Junior on 2025-07-22.
//

import Foundation

extension DateFormatter {
    static let dayOfWeekFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE" // e.g., "Mon"
        return formatter
    }()

    static let monthDayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d" // e.g., "Jul 22"
        return formatter
    }()
    
    static let longDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }()
    
    static let hourFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h a"
        return formatter
    }()
}

extension Date {
    var toDaysOfWeek: String {
        DateFormatter.dayOfWeekFormatter.string(from: self)
    }
    
    var toMonths: String {
        DateFormatter.monthDayFormatter.string(from: self)
    }
    
    var toLongDate: String {
        DateFormatter.longDateFormatter.string(from: self)
    }
    
    var toHour: String {
        DateFormatter.hourFormatter.string(from: self)
    }
}

