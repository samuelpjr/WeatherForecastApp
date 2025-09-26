//
//  MainWeatherViewModelTests.swift
//  WeatherForecastAppTests
//
//  Created by Samuel Pinheiro Junior on 2025-07-24.
//

import XCTest
@testable import WeatherForecastApp


@MainActor
final class MainWeatherViewModelTests: XCTestCase, Sendable {
    
    var mockUseCase: MockWeatherUseCase!
    var viewModel: MainWeatherViewModel!
    
    
    override func setUp() async throws {
        try await super.setUp()
        await MainActor.run {
            mockUseCase = MockWeatherUseCase()
            viewModel = MainWeatherViewModel(getCurrentWeatherUseCase: mockUseCase!)
        }
    }

    
    override func tearDown() async throws {
        mockUseCase = nil
        viewModel = nil
        try await super.tearDown()
    }

    
    func testFetchLocationBy_ShouldPopulateLocationsAndSetLoadedState() async {
        let exp = expectation(description: "Location fetched")
        
        await viewModel.fetchLocationBy(cityName: "Any")
        
        // Wait for the async task to complete
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            exp.fulfill()
        }
        
        await fulfillment(of: [exp], timeout: 1.0)
        
        XCTAssertEqual(viewModel.locationsList.count, 1)
        XCTAssertEqual(viewModel.locationsList.first!.name, "Any")
        XCTAssertEqual(viewModel.viewState, .loaded)
    }
    
    func testFetchWeatherData_ShouldPopulateHeaderAndDailyForecastAndSetLoadedState() async {
        let exp = expectation(description: "Weather fetched")
        
        await viewModel.fetchWeatherData()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            exp.fulfill()
        }
        
        await fulfillment(of: [exp], timeout: 1.0)
        
        XCTAssertEqual(viewModel.cityName, "Mock City")
        XCTAssertEqual(viewModel.currentTemperature, "34°")
        XCTAssertEqual(viewModel.currentWeatherDescription, "Clear Sky")
        XCTAssertEqual(viewModel.dailyForecasts.count, 1)
        XCTAssertEqual(viewModel.viewState, .loaded)
    }

    
    func testFetchWeatherData_WhenError_ShouldSetErrorState() async {
        mockUseCase.shouldThrow = true
        
        let exp = expectation(description: "Error thrown")
        
        await viewModel.fetchWeatherData()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            exp.fulfill()
        }
        
        await fulfillment(of: [exp], timeout: 1.0)
        
        if case .error(let message) = viewModel.viewState {
            XCTAssertNotNil(message)
        } else {
            XCTFail("Expected .error state")
        }
    }
}

