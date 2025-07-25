//
//  HourlyChartDataPoint.swift
//  WeatherForecastApp
//
//  Created by Samuel Pinheiro Junior on 2025-07-24.
//

import Foundation

struct HourlyChartDataPoint: Identifiable {
    let id = UUID()
    let hour: String
    let temperature: Double
}
