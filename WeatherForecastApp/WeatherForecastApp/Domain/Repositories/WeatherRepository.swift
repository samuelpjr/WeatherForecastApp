//
//  WeatherRepository.swift
//  WeatherForecastApp
//
//  Created by Samuel Pinheiro Junior on 2025-07-22.
//


protocol WeatherRepositoryProtocol {
    
    @MainActor func fetchCurrentForecastBy(coordinates: WeatherApiEndPoint) async throws -> CurrentForecastModel
    
    @MainActor func fetchDailyForecastBy(coordinates: WeatherApiEndPoint) async throws -> DailyForecastModel
    
    @MainActor func fetchHourlyForecastBy(coordinates: WeatherApiEndPoint) async throws -> HourlyForecastModel
    
    @MainActor func fetch(_ city: WeatherApiEndPoint) async throws -> [LocationByCityModel]
}


