//
//  GetWeatherUseCase.swift
//  WeatherForecastApp
//
//  Created by Samuel Pinheiro Junior on 2025-07-22.
//

import Foundation


protocol GetWeatherUseCaseProtocol {
    @MainActor func executeCurrent(_ location: (lat: Double, lon: Double)?) async throws -> CurrentForecastModel
    @MainActor func executeDaily(_ location: (lat: Double, lon: Double)?) async throws -> DailyForecastModel
    @MainActor func executeHourly(_ location: (lat: Double, lon: Double)?) async throws -> HourlyForecastModel
    @MainActor func executeLocation(for city: String) async throws -> [LocationByCityModel]
}

@MainActor
class GetWeatherUseCase: GetWeatherUseCaseProtocol {
    private let weatherRepository: WeatherRepositoryProtocol
    private let locationManager: LocationServiceProtocol
    
    init(weatherRepository: WeatherRepositoryProtocol, locationManager: LocationServiceProtocol = LocationService()) {
        self.locationManager = locationManager
        self.weatherRepository = weatherRepository
    }

    func executeCurrent(_ city: (lat: Double, lon: Double)? = nil) async throws -> CurrentForecastModel {
        let locale = try await locationHandler(city)
        return try await weatherRepository.fetchCurrentForecastBy(coordinates: WeatherApiEndPoint.currentForecast(lat: locale.lat, lon: locale.lon))
    }
    
    func executeDaily(_ city: (lat: Double, lon: Double)? = nil) async throws -> DailyForecastModel {
        let locale = try await locationHandler(city)
        return try await weatherRepository.fetchDailyForecastBy(coordinates: .dailyForecast(latitude: locale.lat, longitude: locale.lon))
    }
    
    func executeHourly(_ city: (lat: Double, lon: Double)? = nil) async throws -> HourlyForecastModel {
        let locale = try await locationHandler(city)

        return try await weatherRepository.fetchHourlyForecastBy(coordinates: .hourlyForecast(lat: locale.lat, lon: locale.lon))
    }
    
    func executeLocation(for city: String) async throws -> [LocationByCityModel] {
        return try await weatherRepository.fetch(.locationBy(city: city))
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
