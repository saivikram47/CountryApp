//
//  CountryListView.swift
//  CountryApp
//
//  Created by Apple on 28/05/25.
//


import SwiftUICore
import SwiftUI

struct CountryListView: View {
    @StateObject var viewModel = CountryListViewModel()

    var body: some View {
        NavigationView {
            VStack {
                TextField("Search country", text: $viewModel.searchQuery)
                    .textFieldStyle(.roundedBorder)
                    .padding()

                List {
                    ForEach(viewModel.filteredCountries) { country in
                        Button {
                            viewModel.addCountry(country)
                        } label: {
                            Text(country.name)
                        }
                    }
                }

                List {
                    ForEach(viewModel.selectedCountries) { country in
                        NavigationLink(destination: CountryDetailView(country: country)) {
                            HStack {
                                Text(country.name)
                                Spacer()
                                Button("Remove") {
                                    viewModel.removeCountry(country)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Countries")
        }
    }
}
