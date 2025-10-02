//
//  LocationService.swift
//  WeatherForecastApp
//
//  Created by Samuel Pinheiro Junior on 2025-07-22.
//



import Foundation
import CoreLocation

struct Coordinates {
    let latitude: Double
    let longitude: Double
}

protocol LocationServiceProtocol {
    @MainActor func getCurrentLocation() async throws -> CLLocationCoordinate2D
}

final class LocationService: LocationServiceProtocol {

    private let locationManager = CLLocationManager()

    init() {
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }

    func getCurrentLocation() async throws -> CLLocationCoordinate2D {
        let status = locationManager.authorizationStatus
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            throw LocationError.authorizationRestricted
        case .denied:
            throw LocationError.authorizationDenied
        case .authorizedAlways, .authorizedWhenInUse:
            break
        @unknown default:
            throw LocationError.unknown
        }

        do {
            let updates = CLLocationUpdate.liveUpdates()
            for try await update in updates {
                guard let location = update.location else {
                    continue
                }

                return location.coordinate
            }
        } catch {
            if let clError = error as? CLError {
                switch clError.code {
                case .denied:
                    throw LocationError.authorizationDenied
                case .locationUnknown:
                    throw LocationError.locationUnavailable
                default:
                    throw LocationError.unknown
                }
            }
            throw LocationError.unknown
        }
        
        throw LocationError.failedToLocate
    }
}
