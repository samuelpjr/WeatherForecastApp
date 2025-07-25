//
//  DailyForecastModel.swift
//  WeatherForecastApp
//
//  Created by Samuel Pinheiro Junior on 2025-07-22.
//

import Foundation


struct DailyForecastModel: Codable {
    let list: [DayliList]
}

struct Coord: Codable {
    let lon, lat: Double
}

struct DayliList: Codable {
    let dt: Int
    let temp: Temp
    let weather: [Weather]
    let pressure, humidity: Int
    let speed: Double
}

struct Temp: Codable {
    let min, max: Double
}

// MARK: - Weather
struct Weather: Codable {
    let description, icon: String
}
