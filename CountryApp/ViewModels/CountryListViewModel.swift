//
//  CountryListViewModel.swift
//  CountryApp
//
//  Created by Apple on 28/05/25.
//

import Foundation
class CountryListViewModel: ObservableObject {
    @Published var countries: [Country] = []
    @Published var selectedCountries: [Country] = []
    @Published var searchQuery = ""

    private let service = CountryService()
    private let persistence = PersistenceService()

    init() {
        loadCountries()
        loadSavedCountries()
    }

    func loadCountries() {
        service.fetchAllCountries { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let countries):
                    self.countries = countries
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    }

    var filteredCountries: [Country] {
        if searchQuery.isEmpty {
            return countries
        } else {
            return countries.filter {
                $0.name.lowercased().contains(searchQuery.lowercased())
            }
        }
    }

    func addCountry(_ country: Country) {
        guard !selectedCountries.contains(country), selectedCountries.count < 5 else { return }
        selectedCountries.append(country)
        persistence.saveCountries(selectedCountries)
    }

    func removeCountry(_ country: Country) {
        selectedCountries.removeAll { $0 == country }
        persistence.saveCountries(selectedCountries)
    }

    func loadSavedCountries() {
        selectedCountries = persistence.loadCountries()
    }
}
