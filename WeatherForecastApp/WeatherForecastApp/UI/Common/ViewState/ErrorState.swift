//
//  ErrorState.swift
//  WeatherForecastApp
//
//  Created by Samuel Pinheiro Junior on 2025-07-23.
//

import SwiftUI

struct ErrorState: View {
    
    let viewModel: MainWeatherViewModel
    
    init(viewModel: MainWeatherViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.largeTitle)
                .foregroundColor(.red)
            Text("Error: \(String(describing: viewModel.errorMessage))")
                .accessibilityIdentifier("ErrorView")
                .font(.headline)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding()
            Button("Retry") {
                Task {
                  await viewModel.fetchWeatherData()
                }
            }
            .buttonStyle(.borderedProminent)
            .tint(.white)
            .foregroundColor(.blue)
        }
    }
}

