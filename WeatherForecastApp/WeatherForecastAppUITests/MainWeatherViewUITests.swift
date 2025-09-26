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
final class MainWeatherViewUITests: XCTestCase, Sendable {
    
    func testSearchBar_ShouldShowTextFieldAndSearchButton() {
        let app = XCUIApplication()
        app.launch()

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

        let locationLabel = app.staticTexts["Toronto, Ontario CA"]
        XCTAssertTrue(locationLabel.exists)
        locationLabel.tap()

//        print(app.debugDescription)
        
        let labels = ["Downtown Toronto", "21°", "Clear Sky", "Clear Sky"]

        let matches = app.staticTexts.matching(identifier: "currentWeatherCardIdentifier")
        let count = matches.count
        
        XCTAssertEqual(count, 3)
        
        for index in 0..<count {
            let element = matches.element(boundBy: index)
            print(element.label)
            XCTAssertEqual(element.label, labels[index])
        }
        
    }
    
    func testDailyForecastRow_ShowsCorrectData() {
        let app = XCUIApplication()
        app.launch()
        let listButton = app.buttons["ListButton"]
        XCTAssertTrue(listButton.waitForExistence(timeout: 2.0))
        XCTAssertTrue(listButton.exists)
        XCTAssertTrue(app.images["WeatherIcon"].exists)
        XCTAssertTrue(app.staticTexts["MinMaxTemp"].exists)
    }
    
    
    func test_LaunchApp_GoToDetailsPage_BackTo_MainPAge()  {
        let app = XCUIApplication()
        app.launch()
        let listButton = app.buttons["ListButton"].firstMatch
        XCTAssertTrue(listButton.waitForExistence(timeout: 2.0))
        XCTAssertTrue(listButton.exists)
        listButton.tap()
        
        let backButton = app.buttons["Back"]
        XCTAssertTrue(backButton.waitForExistence(timeout: 2.0))
        XCTAssertTrue(backButton.exists)
        backButton.tap()
    }
}
