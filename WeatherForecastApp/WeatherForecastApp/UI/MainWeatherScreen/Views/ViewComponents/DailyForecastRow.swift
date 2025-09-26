//
//  DailyForecastRow.swift
//  WeatherForecastApp
//
//  Created by Samuel Pinheiro Junior on 2025-07-22.
//

import SwiftUI

struct DailyForecastRow: View {
    let forecast: DailyForecastItemViewModel

    var body: some View {
        HStack {
            Text(forecast.dayOfWeek)
                .font(.headline)
                .foregroundColor(.white)
                .frame(width: 60, alignment: .leading)
                .accessibilityIdentifier("DayOfWeek")

            Spacer()

            Image(systemName: forecast.weatherIconName)
                .renderingMode(.original)
                .font(.title2)
                .accessibilityIdentifier("WeatherIcon")

            Spacer()

            Text("🥶 \(forecast.minTemperature)  -  \(forecast.maxTemperature) 🥵")
                .font(.headline)
                .foregroundColor(.white)
                .frame(width: 180, alignment: .trailing)
                .accessibilityIdentifier("MinMaxTemp")
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 20)
    }
}

#Preview {
    let vm = DailyForecastItemViewModel(dayOfWeek: "Mon", dateString: "", minTemperature: "10", maxTemperature: "30", weatherIconName: "sun.max.fill", dayTime: 4)
    DailyForecastRow(forecast: vm)
}
