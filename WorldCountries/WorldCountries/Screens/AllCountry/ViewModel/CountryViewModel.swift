//
//  CountryViewModel.swift
//  WorldCountries
//
//  Created by Кирилл Коновалов on 16.01.2025.
//

import CoreData
import SwiftUI

class CountryViewModel: ObservableObject {
	private let countryService = ApiWrapper()
	private let container: NSPersistentContainer
	private let context: NSManagedObjectContext

	@Published var allCountries: [AllCountryModel] = []
	@Published var searchQuery: String = ""
	@Published var loadError: Bool = false
	@Published var favoriteCountries: [CountryEntity] = []

	init(container: NSPersistentContainer) {
		self.container = container
		self.context = container.viewContext
		getAllCountries()
		loadFavorites()
	}

	// Загрузка всех стран
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

	// Фильтрация стран по названию
	var filteredCountries: [AllCountryModel] {
		if searchQuery.isEmpty {
			return allCountries
		} else {
			return allCountries.filter {
				$0.name?.common?.localizedCaseInsensitiveContains(searchQuery) == true
			}
		}
	}

	// Загрузка избранного из БД
	func loadFavorites() {
		let fetchRequest: NSFetchRequest<CountryEntity> = CountryEntity.fetchRequest()
		do {
			favoriteCountries = try context.fetch(fetchRequest)
		} catch {
			debugPrint("Ошибка загрузки избранного: \(error)")
		}
	}

	// Добавление/удаление страны из избранного
	func toggleFavorite(country: AllCountryModel) {
		let fetchRequest: NSFetchRequest<CountryEntity> = CountryEntity.fetchRequest()
		fetchRequest.predicate = NSPredicate(format: "name == %@", country.name?.common ?? "")

		do {
			let result = try context.fetch(fetchRequest)
			if let existingCountry = result.first {
				context.delete(existingCountry)
			} else {
				let favoriteCountry = CountryEntity(context: context)
				favoriteCountry.id = country.id
				favoriteCountry.name = country.name?.common
				favoriteCountry.flagURL = country.flags?.png
				favoriteCountry.region = country.region ?? ""
			}
			try context.save()
			loadFavorites()
		} catch {
			debugPrint("Error toggle favorite: \(error)")
		}
	}

	// Проверка, находится ли страна в избранном
	func isFavorite(country: AllCountryModel) -> Bool {
		return favoriteCountries.contains { $0.name == country.name?.common }
	}
	
	// Удаление страны из избранных
	func delete(at offsets: IndexSet) {
		for index in offsets {
			let countryToDelete = favoriteCountries[index]
			context.delete(countryToDelete)
		}
		saveContext()
	}
	
	private func saveContext() {
		do {
			try context.save()
			loadFavorites()
		} catch {
			debugPrint("Error saving context: \(error)")
		}
	}
}
