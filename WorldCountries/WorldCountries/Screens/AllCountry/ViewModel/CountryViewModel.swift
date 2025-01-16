//
//  CountryViewModel.swift
//  WorldCountries
//
//  Created by Кирилл Коновалов on 16.01.2025.
//

import SwiftUI

class CountryViewModel: ObservableObject {
	let countryService = ApiWrapper()

	@Published var allCountries: [AllCountryModel] = []
	@Published var searchQuery: String = ""
	@Published var loadError: Bool = false
	@Published var favoriteCountries: [AllCountryModel] = []

	init() {
		getAllCountries()
		loadFavorites()
	}
	
	/// Загрузка всех стран
	func getAllCountries() {
		countryService.fetchAllCountries { result in
			switch result {
			case .success(let countries):
				DispatchQueue.main.async {
					self.allCountries = countries
				}
			case .failure(_):
				DispatchQueue.main.async {
					self.loadError.toggle()
				}
			}
		}
	}
	
	/// Фильтрация стран по названию
	var filteredCountries: [AllCountryModel] {
		if searchQuery.isEmpty {
			return allCountries
		} else {
			return allCountries.filter {
				$0.name?.common?.localizedCaseInsensitiveContains(searchQuery) == true
			}
		}
	}

	/// Загружаем избранные страны
	func loadFavorites() {
		// Загрузка избранных стран из локальной памяти или сохраненных данных (если они есть)
	}

	/// Добавление/удаление страны из избранного
	func toggleFavorite(country: AllCountryModel) {
		if let index = favoriteCountries.firstIndex(where: { $0.name?.common == country.name?.common }) {
			favoriteCountries.remove(at: index)
		} else {
			favoriteCountries.append(country)
		}
	}

	/// Проверка, находится ли страна в избранном
	func isFavorite(country: AllCountryModel) -> Bool {
		return favoriteCountries.contains { $0.name?.common == country.name?.common }
	}
}
