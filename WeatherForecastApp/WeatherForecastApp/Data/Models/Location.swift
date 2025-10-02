//
//  Location.swift
//  WeatherForecastApp
//
//  Created by Samuel Pinheiro Junior on 2025-07-24.
//

import Foundation

struct Location: Codable, Identifiable {
    var id: UUID = UUID()
    var name: String
    var state: String
    var country: String
    var lat: Double
    var lon: Double
}
