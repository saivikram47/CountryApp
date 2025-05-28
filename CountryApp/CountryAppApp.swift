//
//  CountryAppApp.swift
//  CountryApp
//
//  Created by Apple on 28/05/25.
//

import SwiftUI

@main
struct CountryAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
