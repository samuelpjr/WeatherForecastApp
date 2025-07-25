//
//  WeatherForecastApp.swift
//  WeatherForecastApp
//
//  Created by Samuel Pinheiro Junior on 2025-07-21.
//

import SwiftUI

@main
struct WeatherForecastApp: App {
    var body: some Scene {
        WindowGroup {
            let view = self.makeMainView()
            view
        }
    }
    
    private func makeMainView() -> MainWeatherView {
        let apiService = APIService()
        let productRepository = APIWeatherRepository(apiService: apiService)
        let getCurrentWeather = GetWeatherUseCase(weatherRepository: productRepository)
        let viewModel = MainWeatherViewModel(getCurrentWeatherUseCase: getCurrentWeather)
        let view = MainWeatherView(viewModel: viewModel)
        return view
    }
}
