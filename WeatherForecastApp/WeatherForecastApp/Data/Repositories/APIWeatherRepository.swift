//
//  APIWeatherRepository.swift
//  WeatherForecastApp
//
//  Created by Samuel Pinheiro Junior on 2025-07-22.
//

import Foundation

@MainActor
class APIWeatherRepository: WeatherRepositoryProtocol {
    
    private let apiService: APIServiceProtocol

    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }

    func fetchCurrentForecastBy(coordinates: WeatherApiEndPoint) async throws -> CurrentForecastModel {
        try await apiService.request(endpoint: coordinates)
    }
    
    func fetchDailyForecastBy(coordinates: WeatherApiEndPoint) async throws -> DailyForecastModel {
        try await apiService.request(endpoint: coordinates)
    }
    
    func fetchHourlyForecastBy(coordinates: WeatherApiEndPoint) async throws -> HourlyForecastModel {
        try await apiService.request(endpoint: coordinates)
    }
    
    func fetch(_ city: WeatherApiEndPoint) async throws -> [LocationByCityModel] {
        try await apiService.request(endpoint: city)
    }
}
