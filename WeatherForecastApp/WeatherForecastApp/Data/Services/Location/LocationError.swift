//
//  LocationError.swift
//  WeatherForecastApp
//
//  Created by Samuel Pinheiro Junior on 2025-07-22.
//

import CoreLocation
import Foundation

enum LocationError: Error, LocalizedError {
    case authorizationDenied
    case authorizationRestricted
    case locationUnavailable
    case failedToLocate
    case unknown

    var errorDescription: String? {
        switch self {
        case .authorizationDenied:
            return "Location access was denied. Please enable it in Settings."
        case .authorizationRestricted:
            return "Location access is restricted on this device."
        case .locationUnavailable:
            return "Location data is currently unavailable."
        case .failedToLocate:
            return "Could not retrieve your location."
        case .unknown:
            return "An unknown error occurred while getting location."
        }
    }
}
