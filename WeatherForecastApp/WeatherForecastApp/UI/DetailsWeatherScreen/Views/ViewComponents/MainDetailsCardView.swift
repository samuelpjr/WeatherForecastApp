//
//  MainDetailsCardView.swift
//  WeatherForecastApp
//
//  Created by Samuel Pinheiro Junior on 2025-07-23.
//

import SwiftUI

struct MainDetailsCardView: View {
    
    @State var viewModel: DetailsWeatherViewModel
    
    init (viewModel: DetailsWeatherViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Text(viewModel.cityName)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .shadow(radius: 5)
                .accessibilityIdentifier("CityNameText")
            
            Text(viewModel.dateString)
                .fontWeight(.medium)
                .foregroundColor(.white)
                .accessibilityIdentifier("DateText")
            
            Image(systemName: viewModel.weatherIconName)
                .font(.system(size: 70))
                .foregroundColor(.yellow)
                .padding()
                .accessibilityIdentifier("WeatherIcon")
            
            Text(viewModel.weatherDescription)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .accessibilityIdentifier("WeatherDescription")
            
            Text(viewModel.temperatureRange)
                .font(.headline)
                .foregroundStyle(.secondary)
                .foregroundColor(.white)
                .accessibilityIdentifier("TemperatureRange")
        }
        .padding()
    }
}


