//
//  MainWeatherViewUITests.swift
//  WeatherForecastApp
//
//  Created by Samuel Pinheiro Junior on 2025-07-25.
//


import XCTest
import SwiftUI
@testable import WeatherForecastApp

@MainActor
final class MainWeatherViewUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testSearchBar_ShouldShowTextFieldAndSearchButton() {
        let searchIcon = app.images["SearchIcon"]
        XCTAssertTrue(searchIcon.waitForExistence(timeout: 5))
        
        searchIcon.tap()
        
        let searchTextField = app.textFields["SearchTextField"]
        XCTAssertTrue(searchTextField.exists)
        
        searchTextField.tap()
        searchTextField.typeText("Toronto")
        
        let searchButton = app.buttons["SearchButton"]
        XCTAssertTrue(searchButton.exists)
        
        searchButton.tap()
        
        XCTAssertTrue(searchIcon.waitForExistence(timeout: 2))
        
        app.buttons["SearchButton"].tap()
        app.staticTexts["Toronto, Ontario CA"].tap()
        
//        let card = app.otherElements["CurrentWeatherCard"]
//        XCTAssertTrue(card.waitForExistence(timeout: 2))
        
//        let cityName = app.textViews["MainViewCityName"]
//        XCTAssertTrue(cityName.exists)
//        XCTAssertEqual(cityName.label, "Downtown Toronto")
    }
    
    
    func testDailyForecastRow_ShowsCorrectData() {
        
        let listButton = app.buttons["ListButton"]
        XCTAssertTrue(listButton.waitForExistence(timeout: 2.0))
        XCTAssertTrue(listButton.exists)
        XCTAssertTrue(app.images["WeatherIcon"].exists)
        XCTAssertTrue(app.staticTexts["MinMaxTemp"].exists)
    }
    
    @MainActor
    func test_LaunchApp_GoToDetailsPage_BackTo_MainPAge() throws {
        
        let listButton = app.buttons["Fri, 🥶 15°  -  24° 🥵"].images["WeatherIcon"]
        XCTAssertTrue(listButton.waitForExistence(timeout: 2.0))
        XCTAssertTrue(listButton.exists)
        listButton.tap()
        
        let backButton = app.buttons["Back"]
        XCTAssertTrue(backButton.waitForExistence(timeout: 2.0))
        XCTAssertTrue(backButton.exists)
        backButton.tap()
    }
}
