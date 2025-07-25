//
//  HourlyForecastModel.swift
//  WeatherForecastApp
//
//  Created by Samuel Pinheiro Junior on 2025-07-23.
//

import Foundation

struct HourlyForecastModel: Codable {
    let list: [HourlyList]
}

struct HourlyList: Codable {
    let dt: Int
    let main: MainClass
}

struct MainClass: Codable {
    let temp: Double
}

