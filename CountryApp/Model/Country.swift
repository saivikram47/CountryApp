//
//  Country.swift
//  CountryApp
//
//  Created by Apple on 28/05/25.
//

import Foundation

struct Country: Identifiable, Codable, Equatable {
    var id: String { alpha2Code } 
    let name: String
    let capital: String?
    let currencies: [Currency]?
    let alpha2Code: String
}

struct Currency: Codable, Equatable {
    let code: String
    let name: String
    let symbol: String?
}
