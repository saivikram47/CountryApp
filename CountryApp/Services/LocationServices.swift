//
//  LocationServices.swift
//  CountryApp
//
//  Created by Apple on 28/05/25.
//


import CoreLocation
// LocationService.swift
class LocationService: NSObject, CLLocationManagerDelegate, ObservableObject {
    private let manager = CLLocationManager()
    @Published var currentCountryCode: String?

    override init() {
        super.init()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, _ in
            self.currentCountryCode = placemarks?.first?.isoCountryCode
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .denied {
            self.currentCountryCode = "IN" // default to your country
        }
    }
}
