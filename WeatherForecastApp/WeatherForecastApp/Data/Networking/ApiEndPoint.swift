//
//  ApiEndPoint.swift
//  WeatherForecastApp
//
//  Created by Samuel Pinheiro Junior on 2025-07-22.
//

import Foundation

protocol Endpoint {
    var url: URL? { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var body: Data? { get }
    var decoder: JSONDecoder { get }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

enum WeatherApiEndPoint {
    case locationBy(city: String)
    case currentForecast(Coordinates)
    case dailyForecast(Coordinates)
    case hourlyForecast(Coordinates)

    #if DEBUG
    case invalidTestEndpoint
    #endif
}

extension WeatherApiEndPoint: Endpoint {
    var method: HTTPMethod {
        switch self {
        case .locationBy, .currentForecast, .dailyForecast, .hourlyForecast:
            return .get
        #if DEBUG
        case .invalidTestEndpoint:
            return .get
        #endif
        }
    }

    var headers: [String : String]? {
        [
            "Accept": "application/json"
        ]
    }

    var body: Data? {
        switch self {
        case .locationBy, .currentForecast, .dailyForecast, .hourlyForecast:
            return nil
        #if DEBUG
        case .invalidTestEndpoint:
            return nil
        #endif
        }
    }

    var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }

    var url: URL? {
        switch self {
        case let .locationBy(city):
            return buildURL(
                path: "/geo/1.0/direct",
                queryItems: [
                    URLQueryItem(name: "q", value: city),
                    URLQueryItem(name: "limit", value: "5")
                ]
            )

        case let .currentForecast(coords):
            return buildURL(
                path: "/data/2.5/weather",
                queryItems: [
                    URLQueryItem(name: "lat", value: String(coords.latitude)),
                    URLQueryItem(name: "lon", value: String(coords.longitude))
                ]
            )

        case let .dailyForecast(coords):
            return buildURL(
                path: "/data/2.5/forecast/daily",
                queryItems: [
                    URLQueryItem(name: "lat", value: String(coords.latitude)),
                    URLQueryItem(name: "lon", value: String(coords.longitude)),
                    URLQueryItem(name: "exclude", value: "minutely,alerts")
                ]
            )

        case let .hourlyForecast(coords):
            return buildURL(
                path: "/data/2.5/forecast",
                queryItems: [
                    URLQueryItem(name: "lat", value: String(coords.latitude)),
                    URLQueryItem(name: "lon", value: String(coords.longitude)),
                    URLQueryItem(name: "exclude", value: "minutely,alerts")
                ]
            )

        #if DEBUG
        case .invalidTestEndpoint:
            return nil
        #endif
        }
    }
}

// MARK: - Private Helpers
private extension WeatherApiEndPoint {
    static let baseScheme = "https"
    static let baseHost   = "api.openweathermap.org"

    var defaultQueryItems: [URLQueryItem] {
        [
            URLQueryItem(name: "appid", value: Secrets.weatherAPIKey),
            URLQueryItem(name: "units", value: "metric")
        ]
    }

    func buildURL(path: String, queryItems: [URLQueryItem]) -> URL? {
        var components = URLComponents()
        components.scheme = Self.baseScheme
        components.host   = Self.baseHost
        components.path   = path
        components.queryItems = queryItems + defaultQueryItems
        return components.url
    }
}
