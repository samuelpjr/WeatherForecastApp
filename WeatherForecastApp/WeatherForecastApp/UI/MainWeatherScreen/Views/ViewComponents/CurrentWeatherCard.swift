//
//  CurrentWeatherCard.swift
//  WeatherForecastApp
//
//  Created by Samuel Pinheiro Junior on 2025-07-23.
//

import SwiftUI

struct CurrentWeatherCard: View {
    
    let viewModel: MainWeatherViewModel
    
    init(viewModel: MainWeatherViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 8) {
            Text(viewModel.cityName)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .shadow(radius: 5)
                .accessibilityIdentifier("MainViewCityName")
            
            Text(viewModel.currentTemperature)
                .font(.system(size: 80, weight: .thin))
                .foregroundColor(.white)
                .shadow(radius: 5)
                .accessibilityIdentifier("MainViewCurrentTemp")

            Image(systemName: viewModel.currentWeatherIconName)
                .renderingMode(.original)
                .font(.system(size: 40))
                .padding(.bottom, 5)
                .accessibilityIdentifier("MainViewIconName")

            Text(viewModel.currentWeatherDescription.capitalized)
                .font(.title3)
                .fontWeight(.medium)
                .foregroundColor(.white)
                .accessibilityIdentifier("MainViewWeatherDescription")
        }
        .accessibilityIdentifier("CurrentWeatherCard")
        .padding(.vertical, 20)
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
        .background(Color.white.opacity(0.15))
        .cornerRadius(20)
        .padding(.horizontal)
    }
}
