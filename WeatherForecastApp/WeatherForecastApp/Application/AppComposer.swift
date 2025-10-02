//
//  AppComposer.swift
//  WeatherForecastApp
//
//  Created by Samuel Pinheiro Junior on 2025-10-01.
//

import Foundation

struct AppComposer {
    
    @MainActor static func composeMainWeatherScreen() -> MainWeatherScreen {
        let apiService = APIService()
        let locationService = LocationService()
        let repository = WeatherRepository(locationManager: locationService, apiService: apiService)
        let viewModel = MainWeatherViewModel(getCurrentWeatherUseCase: repository)
        let view = MainWeatherScreen(viewModel: viewModel)
        return view
    }
}
