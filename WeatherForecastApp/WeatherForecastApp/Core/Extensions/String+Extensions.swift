//
//  String+Extensions.swift
//  WeatherForecastApp
//
//  Created by Samuel Pinheiro Junior on 2025-07-24.
//

import Foundation

extension String {
    var mapWeatherIcon: String {
        switch self {
        case "01d":        return "sun.max.fill"
        case "01n":        return "moon.fill"
        case "02d":        return "cloud.sun.fill"
        case "02n":        return "cloud.moon.fill"
        case "03d", "03n": return "cloud.fill"
        case "04d", "04n": return "cloud.heavyrain.fill"
        case "09d", "09n": return "cloud.rain.fill"
        case "10d", "10n": return "cloud.sun.rain.fill"
        case "11d", "11n": return "cloud.bolt.fill"
        case "13d", "13n": return "cloud.snow.fill"
        case "50d", "50n": return "cloud.fog.fill"
        default:           return "questionmark.circle.fill"
        }
    }
}
