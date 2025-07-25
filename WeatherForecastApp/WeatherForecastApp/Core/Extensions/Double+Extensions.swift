//
//  Double+Extensions.swift
//  WeatherForecastApp
//
//  Created by Samuel Pinheiro Junior on 2025-07-24.
//

import Foundation

extension Double {
    var doubleToString: String {
        String(format: "%.0f°", self)
    }
    
    var doubleToDate: Date {
        Date(timeIntervalSince1970: self)
    }
    
    var doubleToSpeed: String {
        String(format: "%.1f m/s", self)
    }
}
