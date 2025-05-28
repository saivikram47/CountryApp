//
//  CountryServices.swift
//  CountryApp
//
//  Created by Apple on 28/05/25.
//

import Foundation
// CountryService.swift
class CountryService {
    func fetchAllCountries(completion: @escaping (Result<[Country], Error>) -> Void) {
        guard let url = URL(string: "https://restcountries.com/v2/all") else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let data = data {
                do {
                    let countries = try JSONDecoder().decode([Country].self, from: data)
                    completion(.success(countries))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
