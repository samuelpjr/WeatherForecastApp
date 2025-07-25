//
//  APIError.swift
//  WeatherForecastApp
//
//  Created by Samuel Pinheiro Junior on 2025-07-22.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case requestFailed(Error)
    case decodingFailed(Error)
    case invalidResponse(statusCode: Int)
    case badServerResponse
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL was invalid. Please check the city name or coordinates."
        case .requestFailed(let error):
            return "A network error occurred: \(error.localizedDescription)"
        case .decodingFailed(let error):
            return "Failed to decode the server response: \(error.localizedDescription)"
        case .invalidResponse(let statusCode):
            return "An unknown error occurred. StatusCode: \(statusCode)"
        case .badServerResponse:
            return "The server responded with an error."
        }
    }
}
