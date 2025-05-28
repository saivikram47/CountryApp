//
//  PersistenceServices.swift
//  CountryApp
//
//  Created by Apple on 28/05/25.
//

import Foundation

class PersistenceService {
    private let key = "SavedCountries"

    func saveCountries(_ countries: [Country]) {
        if let data = try? JSONEncoder().encode(countries) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    func loadCountries() -> [Country] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let countries = try? JSONDecoder().decode([Country].self, from: data)
        else { return [] }
        return countries
    }
}
