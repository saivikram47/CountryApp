//
//  LocationServices.swift
//  CountryApp
//
//  Created by Apple on 28/05/25.
//


import CoreLocation

import Foundation
import CoreLocation
import Combine

class LocationService: NSObject, CLLocationManagerDelegate, ObservableObject {
    private let manager = CLLocationManager()
    
    @Published var currentCountryCode: String?

    override init() {
        super.init()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
    }

    // Called when location permissions change
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.startUpdatingLocation()
        case .denied, .restricted:
            // Default to India if denied or restricted
            DispatchQueue.main.async {
                self.currentCountryCode = "IN"
            }
        case .notDetermined:
            break
        @unknown default:
            break
        }
    }


    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }

        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let code = placemarks?.first?.isoCountryCode {
                DispatchQueue.main.async {
                    self.currentCountryCode = code
                }
            } else {
                DispatchQueue.main.async {
                    self.currentCountryCode = "IN"
                }
            }
        }

    }
}
