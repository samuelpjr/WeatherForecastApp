//
//  MockWeatherUseCase.swift
//  WeatherForecastApp
//
//  Created by Samuel Pinheiro Junior on 2025-07-24.
//


import XCTest
@testable import WeatherForecastApp

final class MockWeatherUseCase: GetWeatherUseCaseProtocol {
    var shouldThrow = false

    func executeCurrent(_ location: (lat: Double, lon: Double)?) async throws -> CurrentForecastModel {
        if shouldThrow { throw URLError(.badServerResponse) }
        return CurrentForecastModel(weather: [CurrentWeather(id: 123, main: "Main...", description: "Clear Sky", icon: "sun.max.fill")], main: Main(temp: 34), visibility: 5000, name: "Mock City")
    }

    func executeDaily(_ location: (lat: Double, lon: Double)?) async throws -> DailyForecastModel {
        let dayWeather = DayliList(
            dt: Int(Date().timeIntervalSince1970),
            temp: .init(min: 10, max: 20),
            weather: [Weather(description: "Clear Sky", icon: "01d")],
            pressure: 1013,
            humidity: 70,
            speed: 5)
        return DailyForecastModel(list: [dayWeather])
    }

    func executeHourly(_ location: (lat: Double, lon: Double)?) async throws -> HourlyForecastModel {
        let hourly = HourlyForecastModel(list: [HourlyList(dt: Int(Date().timeIntervalSince1970), main: .init(temp: 15))])
        return hourly
    }

    func executeLocation(for city: String) async throws -> [LocationByCityModel] {
        return [LocationByCityModel(name: city, lat: 0, lon: 0, country: "Globe", state: "ON")]
    }
}

