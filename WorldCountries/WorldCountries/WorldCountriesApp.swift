//
//  WorldCountriesApp.swift
//  WorldCountries
//
//  Created by Кирилл Коновалов on 16.01.2025.
//

import SwiftUI
import CoreData

@main
struct WorldCountriesApp: App {
	let persistentContainer: NSPersistentContainer

	init() {
		persistentContainer = NSPersistentContainer(name: "CountryModel")
		persistentContainer.loadPersistentStores { description, error in
			if let error = error {
				fatalError("\(error.localizedDescription)")
			}
		}
	}

	var body: some Scene {
		WindowGroup {
			MainScreen(persistentContainer: persistentContainer)
		}
	}
}

