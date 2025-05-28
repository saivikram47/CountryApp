//
//  CountryDetailView.swift
//  CountryApp
//
//  Created by Apple on 28/05/25.
//

import SwiftUICore

struct CountryDetailView: View {
    
    let country: Country
    var body: some View {
        VStack(spacing: 16) {
            Text("Capital: \(country.capital ?? "N/A")")
            if let currencies = country.currencies {
                ForEach(currencies, id: \.code) { currency in
                    Text("Currency: \(currency.name) (\(currency.code))")
                }
            } else {
                Text("Currency: N/A")
            }
        }
        .padding()
        .navigationTitle(country.name)
    }
}
