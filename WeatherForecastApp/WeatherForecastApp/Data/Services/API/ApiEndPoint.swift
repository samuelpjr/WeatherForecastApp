//
//  ApiEndPoint.swift
//  WeatherForecastApp
//
//  Created by Samuel Pinheiro Junior on 2025-07-22.
//

import Foundation

enum WeatherApiEndPoint {
    static let apiKey = "API KEY HERE"

    case locationBy(city: String)
    case currentForecast(lat: Double, lon: Double)
    case dailyForecast(latitude: Double, longitude: Double)
    case hourlyForecast(lat: Double, lon: Double)
    #if DEBUG
    case invalidTestEndpoint
    #endif

}

extension WeatherApiEndPoint {
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.openweathermap.org"
        
        switch self {
        case let .locationBy(city):
            components.path = "/geo/1.0/direct"
            components.queryItems = [
                URLQueryItem(name: "q", value: city),
                URLQueryItem(name: "limit", value: "5"),
                URLQueryItem(name: "appid", value: Self.apiKey),
                URLQueryItem(name: "units", value: "metric")
            ]
            return components.url
            
        case let .currentForecast(lat, lon):
            components.path = "/data/2.5/weather"
            components.queryItems = [
                URLQueryItem(name: "lat", value: "\(lat)"),
                URLQueryItem(name: "lon", value: "\(lon)"),
                URLQueryItem(name: "appid", value: Self.apiKey),
                URLQueryItem(name: "units", value: "metric")
            ]
            return components.url
            
        case let .dailyForecast(latitude, longitude):
            components.path = "/data/2.5/forecast/daily"
            components.queryItems = [
                URLQueryItem(name: "lat", value: String(latitude)),
                URLQueryItem(name: "lon", value: String(longitude)),
                URLQueryItem(name: "appid", value: Self.apiKey),
                URLQueryItem(name: "units", value: "metric"),
                URLQueryItem(name: "exclude", value: "minutely,alerts")
            ]
            return components.url
            
        case let .hourlyForecast(lat, lon):
            components.path = "/data/2.5/forecast"
            components.queryItems = [
                URLQueryItem(name: "lat", value: String(lat)),
                URLQueryItem(name: "lon", value: String(lon)),
                URLQueryItem(name: "appid", value: Self.apiKey),
                URLQueryItem(name: "units", value: "metric"),
                URLQueryItem(name: "exclude", value: "minutely,alerts")
            ]
            return components.url
            
        #if DEBUG
            case .invalidTestEndpoint:
            return nil
        #endif
        }
    }
}

