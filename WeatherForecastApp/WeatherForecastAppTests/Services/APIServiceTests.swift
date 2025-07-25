//
//  APIServiceTests.swift
//  WeatherForecastApp
//
//  Created by Samuel Pinheiro Junior on 2025-07-24.
//


import XCTest
@testable import WeatherForecastApp

final class APIServiceTests: XCTestCase {

    private var apiService: APIService!
    private var session: URLSession!

    override func setUpWithError() throws {

        let config = URLSessionConfiguration.ephemeral
            config.protocolClasses = [MockURLProtocol.self]
            session = URLSession(configuration: config)

            apiService = APIService(session: session)
    }

    override func tearDown() {
        apiService = nil
        session = nil
        MockURLProtocol.stubResponseData = nil
        MockURLProtocol.stubStatusCode = 200
        MockURLProtocol.stubError = nil
        super.tearDown()
    }
    
    @MainActor
    func testRequest_Success_ShouldReturnDecodedObject() async throws {
        // Given
        let mockJSON = """
        {
          "weather": [
            {
              "id": 800,
              "main": "Clear",
              "description": "clear sky",
              "icon": "01d"
            }
          ],
          "main": {
            "temp": 21.5
          },
          "visibility": 5000,
          "name": "Mock City"
        }
        """.data(using: .utf8)!

        
        MockURLProtocol.stubResponseData = mockJSON
        MockURLProtocol.stubStatusCode = 200

        let endpoint = WeatherApiEndPoint.currentForecast(lat: 0, lon: 0)

        // When
        let result: CurrentForecastModel = try await apiService.request(endpoint: endpoint)

        // Then
        XCTAssertEqual(result.name, "Mock City")
        XCTAssertEqual(result.visibility, 5000)
    }

    func testRequest_InvalidURL_ShouldThrowInvalidURL() async {
        // Given
        let badEndpoint = WeatherApiEndPoint.invalidTestEndpoint

        // When/Then
        do {
            let _: CurrentForecastModel = try await apiService.request(endpoint: badEndpoint)
            XCTFail("Should throw")
        } catch let error as APIError {
            switch error {
            case .invalidURL:
                XCTAssertTrue(true)
            default:
                XCTFail("Wrong error: \(error)")
            }
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func testRequest_BadStatusCode_ShouldThrowInvalidResponse() async {
        // Given
        let mockJSON = "{}".data(using: .utf8)!
        MockURLProtocol.stubResponseData = mockJSON
        MockURLProtocol.stubStatusCode = 404

        let endpoint = WeatherApiEndPoint.currentForecast(lat: 0, lon: 0)

        // When/Then
        do {
            let _: CurrentForecastModel = try await apiService.request(endpoint: endpoint)
            XCTFail("Should throw")
        } catch let error as APIError {
            switch error {
            case .invalidResponse(let code):
                XCTAssertEqual(code, 404)
            default:
                XCTFail("Wrong error: \(error)")
            }
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func testRequest_DecodingFails_ShouldThrowDecodingFailed() async {
        // Given
        let badJSON = """
        { "invalid_field": "oops" }
        """.data(using: .utf8)!
        MockURLProtocol.stubResponseData = badJSON
        MockURLProtocol.stubStatusCode = 200

        let endpoint = WeatherApiEndPoint.currentForecast(lat: 0, lon: 0)

        // When/Then
        do {
            let _: CurrentForecastModel = try await apiService.request(endpoint: endpoint)
            XCTFail("Should throw")
        } catch let error as APIError {
            switch error {
            case .decodingFailed:
                XCTAssertTrue(true)
            default:
                XCTFail("Wrong error: \(error)")
            }
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}
