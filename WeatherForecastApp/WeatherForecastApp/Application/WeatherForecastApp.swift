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
            let view = AppComposer.composeMainWeatherScreen()
            view
        }
    }
}
