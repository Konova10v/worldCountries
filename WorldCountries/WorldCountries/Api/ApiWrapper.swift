//
//  ApiWrapper.swift
//  WorldCountries
//
//  Created by Кирилл Коновалов on 16.01.2025.
//

import Foundation

final class ApiWrapper {
	func fetchAllCountries(completion: @escaping (Result<[AllCountryModel], Error>) -> Void) {
			// URL for the API
			guard let url = URL(string: "https://restcountries.com/v3.1/all") else {
				completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
				return
			}
			
			// URLSession Data Task
			let task = URLSession.shared.dataTask(with: url) { data, response, error in
				if let error = error {
					completion(.failure(error))
					return
				}
				
				guard let data = data else {
					completion(.failure(NSError(domain: "No data received", code: -2, userInfo: nil)))
					return
				}
				
				do {
					// Decode JSON response
					let countries = try JSONDecoder().decode([AllCountryModel].self, from: data)
					completion(.success(countries))
				} catch {
					completion(.failure(error))
				}
			}
			
			task.resume()
		}
}

