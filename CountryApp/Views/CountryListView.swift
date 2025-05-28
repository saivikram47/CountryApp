//
//  CountryListView.swift
//  CountryApp
//
//  Created by Apple on 28/05/25.
//
import SwiftUICore
import SwiftUI

struct CountryListView: View {
    @EnvironmentObject var locationService: LocationService
    @StateObject var viewModel = CountryListViewModel()

    // Track if user removed detected country so it won't auto-readd
    @State private var hasUserRemovedDetectedCountry = false

    var body: some View {
        NavigationView {
            VStack {
                TextField("Search country", text: $viewModel.searchQuery)
                    .textFieldStyle(.roundedBorder)
                    .padding()

                // List of all countries to add
                List {
                    ForEach(viewModel.filteredCountries) { country in
                        Button {
                            viewModel.addCountry(country)
                            // Reset removal flag if user manually adds detected country back
                            if country.alpha2Code.uppercased() == locationService.currentCountryCode?.uppercased() {
                                hasUserRemovedDetectedCountry = false
                            }
                        } label: {
                            Text(country.name)
                        }
                    }
                }

                // List of selected countries (including detected/default)
                List {
                    ForEach(viewModel.selectedCountries) { country in
                        HStack {
                            NavigationLink(destination: CountryDetailView(country: country)) {
                                Text(country.name)
                                    .foregroundColor(.primary)
                            }
                            Spacer()
                            Button(action: {
                                viewModel.removeCountry(country)
                                // If user removes detected country, set removal flag
                                if country.alpha2Code.uppercased() == locationService.currentCountryCode?.uppercased() {
                                    hasUserRemovedDetectedCountry = true
                                }
                            }) {
                                Text("Remove")
                                    .foregroundColor(.red)
                            }
                            .buttonStyle(BorderlessButtonStyle())
                        }
                    }
                }
            }
            .navigationTitle("Countries")
            .onReceive(locationService.$currentCountryCode) { code in
                guard let code = code else { return }

                // Only add if user has NOT removed detected country and it's not already selected
                if !hasUserRemovedDetectedCountry &&
                    !viewModel.selectedCountries.contains(where: { $0.alpha2Code.uppercased() == code.uppercased() }) {

                    if let country = viewModel.countries.first(where: { $0.alpha2Code.uppercased() == code.uppercased() }) {
                        viewModel.addCountry(country)
                    } else if code == "IN" {
                        if let india = viewModel.countries.first(where: { $0.alpha2Code == "IN" }) {
                            viewModel.addCountry(india)
                        }
                    }
                }
            }
        }
    }
}
