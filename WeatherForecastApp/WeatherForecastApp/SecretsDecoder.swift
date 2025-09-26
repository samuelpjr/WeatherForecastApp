//
//  SecretsDecoder.swift
//  WeatherForecastApp
//
//  Created by Samuel Pinheiro Junior on 2025-09-26.
//

import Foundation

enum Secrets {
    static var weatherAPIKey: String {
        guard let apiKey = Bundle.main.infoDictionary?["WEATHER_API_KEY"] as? String else {
            fatalError("Missing Weather API Key")
        }
        return apiKey
    }
}
