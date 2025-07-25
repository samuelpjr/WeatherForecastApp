//
//  MainViewModel.swift
//  WeatherForecastApp
//
//  Created by Samuel Pinheiro Junior on 2025-07-22.
//

import Foundation
import SwiftUI

@MainActor
@Observable
final class MainWeatherViewModel {

    // MARK: Header
    var cityName: String = "Loading..."
    var currentTemperature: String = "--°"
    var currentWeatherIconName: String = "questionmark.circle.fill"
    var currentWeatherDescription: String = "..."
    
    // MARK: Lists
    var dailyForecasts: [DailyForecastItemViewModel] = []
    var locationsList: [Location] = []
    
    // MARK: State View
    var errorMessage: String? = nil
    var viewState: ViewState = .loading
    
    // MARK: Dependencies
    let getCurrentWeatherUseCase: GetWeatherUseCaseProtocol
    var locale: (lat: Double, lon: Double)?

    init(getCurrentWeatherUseCase: GetWeatherUseCaseProtocol) {
        self.getCurrentWeatherUseCase = getCurrentWeatherUseCase
    }
    
    func fetchLocationBy(cityName: String) async {
        viewState = .loading
        do {
            let locations = try await getCurrentWeatherUseCase.executeLocation(for: cityName)
            self.locationsList = locations.map { Location(name: $0.name,state: $0.state,country: $0.country,lat: $0.lat,lon: $0.lon) }
            self.viewState = .loaded
        } catch {
            self.errorMessage = (error as? LocalizedError)?.errorDescription ?? error.localizedDescription
            self.viewState = .error((error as? LocalizedError)?.errorDescription ?? error.localizedDescription)
        }
    }
    
    func fetchWeatherData(_ cityLocation: (lat: Double, lon: Double)? = nil) async {
        locale = cityLocation
        viewState = .loading
        do {
            
            let currentForecast = try await getCurrentWeatherUseCase.executeCurrent(cityLocation)
            let dailyForecast = try await getCurrentWeatherUseCase.executeDaily(cityLocation)
            
            await populateData(currentForecast, dailyForecast)
            self.viewState = .loaded
            
        } catch {
            self.viewState = .error((error as? LocalizedError)?.errorDescription ?? error.localizedDescription)
        }    
    }
    
    private func populateData(_ current: CurrentForecastModel, _ daily: DailyForecastModel) async {
        await createHeader(current)
        await createDailyForecastList(daily)
    }
    
    private func createHeader(_ currentForecast: CurrentForecastModel) async {
        self.cityName = currentForecast.name
        self.currentTemperature = currentForecast.main.temp.doubleToString
        self.currentWeatherDescription = currentForecast.weather.first?.description ?? "N/A"
        self.currentWeatherIconName = currentForecast.weather.first?.icon.mapWeatherIcon ?? ""
    }
    
    private func createDailyForecastList(_ dailyForecast: DailyForecastModel) async {
        self.dailyForecasts = dailyForecast.list.map { daily in
            DailyForecastItemViewModel(
                dayOfWeek: daily.dt.intToDate.toDaysOfWeek,
                dateString: daily.dt.intToDate.toMonths,
                minTemperature: daily.temp.min.doubleToString,
                maxTemperature: daily.temp.max.doubleToString,
                weatherIconName: daily.weather.first?.icon.mapWeatherIcon ?? "",
                dayTime: daily.dt
            )
        }
    }
}
