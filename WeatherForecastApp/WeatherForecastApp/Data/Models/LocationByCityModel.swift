//
//  LocationByCityModel.swift
//  WeatherForecastApp
//
//  Created by Samuel Pinheiro Junior on 2025-07-24.
//

import Foundation

struct LocationByCityModel: Codable {
    let name: String
    let lat, lon: Double
    let country, state: String
}

