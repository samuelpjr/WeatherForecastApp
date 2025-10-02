//
//  GetWeatherUseCase.swift
//  WeatherForecastApp
//
//  Created by Samuel Pinheiro Junior on 2025-07-22.
//

import Foundation


protocol WeatherRepositoryProtocol {
    @MainActor func executeCurrentForecast(_ location: (lat: Double, lon: Double)?) async throws -> CurrentForecastModel
    @MainActor func executeDailyForecast(_ location: (lat: Double, lon: Double)?) async throws -> DailyForecastModel
    @MainActor func executeHourlyForecast(_ location: (lat: Double, lon: Double)?) async throws -> HourlyForecastModel
    @MainActor func executeLocation(for city: String) async throws -> [LocationByCityModel]
}

@MainActor
class WeatherRepository: WeatherRepositoryProtocol {
    
    private let apiService: APIServiceProtocol
    private let locationManager: LocationServiceProtocol
    
    init(locationManager: LocationServiceProtocol, apiService: APIServiceProtocol) {
        self.locationManager = locationManager
        self.apiService = apiService
    }

    func executeCurrentForecast(_ city: (lat: Double, lon: Double)? = nil) async throws -> CurrentForecastModel {
        let locale = try await locationHandler(city)
        let coordinates = Coordinates(latitude: locale.lat, longitude: locale.lon)
        return try await apiService.request(endpoint: .currentForecast(coordinates))
    }
    
    func executeDailyForecast(_ city: (lat: Double, lon: Double)? = nil) async throws -> DailyForecastModel {
        let locale = try await locationHandler(city)
        let coordinates = Coordinates(latitude: locale.lat, longitude: locale.lon)
        return try await apiService.request(endpoint: .dailyForecast(coordinates))
    }
    
    func executeHourlyForecast(_ city: (lat: Double, lon: Double)? = nil) async throws -> HourlyForecastModel {
        let locale = try await locationHandler(city)
        let coordinates = Coordinates(latitude: locale.lat, longitude: locale.lon)
        return try await apiService.request(endpoint: .hourlyForecast(coordinates))
    }
    
    func executeLocation(for city: String) async throws -> [LocationByCityModel] {
        return try await apiService.request(endpoint:.locationBy(city: city))
    }
    
    private func locationHandler(_ cityLocation: (lat: Double, lon: Double)?) async throws -> (lat: Double, lon: Double) {
        var locale: (lat: Double, lon: Double) = (lat: 0, lon: 0)
                
        if let cityLocation {
            locale = cityLocation
        } else {
            let coordinates = try await locationManager.getCurrentLocation()
            locale = (lat: coordinates.latitude, lon: coordinates.longitude)
        }
        return locale
    }
}
