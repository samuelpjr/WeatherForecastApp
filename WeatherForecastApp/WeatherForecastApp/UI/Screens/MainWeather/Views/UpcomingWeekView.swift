//
//  UpcomingWeekView.swift
//  WeatherForecastApp
//
//  Created by Samuel Pinheiro Junior on 2025-07-23.
//

import SwiftUI

struct UpcomingWeekView: View {
    
    @State var dailyForecasts: [DailyForecastItemViewModel]
    @State var useCase: WeatherRepository
    @Binding var locale: (lat: Double, lon: Double)?
    
    init(dailyForecasts: [DailyForecastItemViewModel], useCase: WeatherRepository, locale: Binding<(lat: Double, lon: Double)?>) {
        self.dailyForecasts = dailyForecasts
        self.useCase = useCase
        _locale = locale
    }
    
    var body: some View {
        VStack {
            Text("Upcoming Week")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding(.vertical, 15)
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
                .accessibilityIdentifier("TitleList")
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 0) {
                    ForEach(dailyForecasts) { forecast in
                        NavigationLink(destination: goToDetails(forecast.dayTime)) {
                            DailyForecastRow(forecast: forecast)
                        }
                        .accessibilityIdentifier("ListButton")
                        
                        if forecast.id != dailyForecasts.last?.id {
                            Divider()
                                .background(Color.white.opacity(0.3))
                                .padding(.horizontal, 20)
                        }
                    }
                }
                .padding(.vertical, 10)
                .background(Color.white.opacity(0.15))
                .cornerRadius(20)
                .padding(.horizontal)
            }
        }.padding(.bottom)
    }
    
    func goToDetails(_ dayTime: Int) -> DetailsWeatherScreen {
        let vm = DetailsWeatherViewModel(useCase: useCase, targetDay: dayTime)
        return DetailsWeatherScreen(viewModel: vm, cityLocation: self.$locale)
    }
}
