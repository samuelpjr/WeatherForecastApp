//
//  DetailsWeatherViewModel.swift
//  WeatherForecastApp
//
//  Created by Samuel Pinheiro Junior on 2025-07-23.
//

import Foundation
import SwiftUI
import Charts

@Observable
@MainActor
final class DetailsWeatherViewModel {

    // MARK: Details Header
    var cityName: String = "Loading..."
    var dateString: String = "Loading..."
    var weatherIconName: String = "questionmark.circle.fill"
    var weatherDescription: String = "..."
    var temperatureRange: String = "--° - --°"
    
    // MARK: Chart
    var hourlyChartData: [HourlyChartDataPoint] = []
    
    // MARK: Details Metrics
    var windSpeed: String = "N/A"
    var humidity: String = "N/A"
    var pressure: String = "N/A"
    var visibility: String = "N/A"
    
    // MARK: State View
    var errorMessage: String? = nil
    var viewState: ViewState = .loading
    
    // MARK: Dependencies
    var targetDay: Int
    private let useCase: GetWeatherUseCaseProtocol
    var cityLocation: (lat: Double, lon: Double)?
    
    init(useCase: GetWeatherUseCaseProtocol, targetDay: Int) {
        self.useCase = useCase
        self.targetDay = targetDay
    }
    
    func fetchData(_ cityLocation: (lat: Double, lon: Double)? = nil) async {
        viewState = .loading
        
        do {
            
            let currentForecast = try await useCase.executeCurrent(cityLocation)
            let dailyForecast = try await useCase.executeDaily(cityLocation)
            let hourlyForecast = try await useCase.executeHourly(cityLocation)
            
            await populateData(currentForecast, dailyForecast, hourlyForecast)
            
            self.viewState = .loaded
        } catch {
            self.errorMessage = (error as? LocalizedError)?.errorDescription ?? error.localizedDescription
            self.viewState = .error((error as? LocalizedError)?.errorDescription ?? error.localizedDescription)
        }
        
    }
    
    private func populateData(_ current: CurrentForecastModel, _ daily: DailyForecastModel, _ hourly: HourlyForecastModel) async {
        let dayWeather = daily.list.filter {$0.dt == self.targetDay}.first ?? daily.list.first!
        await createDetailsHeader(dayWeather, current)
        await createChart(hourly)
        await createDetailsMetrics(dayWeather, current)
    }

    private func createDetailsHeader(_ dayWeather: DayliList, _ current: CurrentForecastModel,) async {
        self.cityName = current.name
        self.dateString = dayWeather.dt.intToDate.toLongDate
        self.weatherIconName = dayWeather.weather.first?.icon.mapWeatherIcon ?? ""
        self.weatherDescription = dayWeather.weather.first?.description.capitalized ?? "N/A"
        self.temperatureRange = "\(dayWeather.temp.min.doubleToString) - \(dayWeather.temp.max.doubleToString)"
    }
    
    private func createChart(_ hourlyForecast: HourlyForecastModel) async {
        let dates = hourlyForecast.list.map { $0.dt.intToDate }
        let filteredByDay = dates.filter { Calendar.current.isDate($0, inSameDayAs: targetDay.intToDate) }
        let sortedHourlyDates = filteredByDay.sorted()
        self.hourlyChartData = zip(sortedHourlyDates, hourlyForecast.list).map {HourlyChartDataPoint(hour: $0.toHour, temperature: $1.main.temp) }
    }
    
    private func createDetailsMetrics(_ dailyWeather: DayliList, _ currentForecast: CurrentForecastModel) async {
        self.windSpeed = dailyWeather.speed.doubleToSpeed
        self.humidity = "\(dailyWeather.humidity.intToString)%"
        self.pressure = "\(dailyWeather.pressure.intToString) hPa"
        self.visibility = createVisibility(currentForecast.visibility)
    }
    
    private func createVisibility(_ visibility: Int) -> String {
        visibility != 0 ? "\(visibility / 1000) km" : "N/A"
    }
}


