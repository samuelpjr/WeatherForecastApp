//
//  Int+Extensions.swift
//  WeatherForecastApp
//
//  Created by Samuel Pinheiro Junior on 2025-07-24.
//

import Foundation

extension Int {
    var intToDate: Date {
        Date(timeIntervalSince1970:Double(self))
    }
    
    var intToString: String {
        String(self)
    }
}
