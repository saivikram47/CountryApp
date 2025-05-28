//
//  CountryAppApp.swift
//  CountryApp
//
//  Created by Apple on 28/05/25.
//

import SwiftUI
import CoreLocation

@main
struct CountryAppApp: App {
    @StateObject private var locationService = LocationService()

    var body: some Scene {
        WindowGroup {
            CountryListView()
                .environmentObject(locationService)
        }
    }
}
