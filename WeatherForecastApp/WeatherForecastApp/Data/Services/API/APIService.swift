//
//  APIService.swift
//  WeatherForecastApp
//
//  Created by Samuel Pinheiro Junior on 2025-07-22.
//

import Foundation

protocol APIServiceProtocol {
    @MainActor func request<T: Decodable>(endpoint: WeatherApiEndPoint) async throws -> T
}


class APIService: APIServiceProtocol {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(endpoint: WeatherApiEndPoint) async throws -> T {
        guard let url = endpoint.url else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let (data, response): (Data, URLResponse)

        do {
            (data, response) = try await session.data(for: request)
        } catch {
            throw APIError.requestFailed(error)
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse(statusCode: -1)
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw APIError.invalidResponse(statusCode: httpResponse.statusCode)
        }

        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            return try decoder.decode(T.self, from: data)
        } catch {
            print("Decoding failed for \(T.self): \(error)")
            throw APIError.decodingFailed(error)
        }
    }
}
