//
//  CurrentForecastModel.swift
//  WeatherForecastApp
//
//  Created by Samuel Pinheiro Junior on 2025-07-22.
//

import Foundation

struct CurrentForecastModel: Codable {
    let weather: [CurrentWeather]
    let main: Main
    let visibility: Int
    let name: String
}

struct Main: Codable {
    let temp: Double
}

struct CurrentWeather: Codable {
    let id: Int
    let main, description, icon: String
}
