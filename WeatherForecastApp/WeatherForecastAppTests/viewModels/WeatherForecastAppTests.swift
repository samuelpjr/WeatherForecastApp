//
//  WeatherForecastAppTests.swift
//  WeatherForecastAppTests
//
//  Created by Samuel Pinheiro Junior on 2025-07-21.
//

import XCTest
@testable import WeatherForecastApp

final class DetailsWeatherViewModelTests: XCTestCase {

    func testFetchData_Success_ShouldUpdateProperties() async {
        // Given
        let mockUseCase = MockWeatherUseCase()
        let viewModel = await DetailsWeatherViewModel(useCase: mockUseCase, targetDay: Int(Date().timeIntervalSince1970))

        // When
        await viewModel.fetchData((lat: 0.0, lon: 0.0))

        // Then
        await MainActor.run {
            XCTAssertEqual(viewModel.cityName, "Mock City")
            XCTAssertEqual(viewModel.weatherDescription, "Clear Sky")
            XCTAssertEqual(viewModel.temperatureRange, "10° - 20°")
            XCTAssertEqual(viewModel.windSpeed, "5.0 m/s")
            XCTAssertEqual(viewModel.humidity, "70%")
            XCTAssertEqual(viewModel.pressure, "1013 hPa")
            XCTAssertEqual(viewModel.visibility, "5 km")
            
            XCTAssertFalse(viewModel.hourlyChartData.isEmpty)
        }
    }
}

