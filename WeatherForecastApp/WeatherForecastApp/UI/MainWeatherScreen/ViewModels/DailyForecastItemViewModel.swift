//
//  DailyForecastItemViewModel.swift
//  WeatherForecastApp
//
//  Created by Samuel Pinheiro Junior on 2025-07-24.
//

import Foundation

struct DailyForecastItemViewModel: Identifiable {
    let id = UUID()
    let dayOfWeek: String
    let dateString: String
    let minTemperature: String
    let maxTemperature: String
    let weatherIconName: String
    let dayTime: Int
}
