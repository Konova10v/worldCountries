//
//  MainScreen.swift
//  WorldCountries
//
//  Created by Кирилл Коновалов on 17.01.2025.
//

import SwiftUI
import CoreData

struct MainScreen: View {
	@ObservedObject private var viewModel: CountryViewModel
	
	init(persistentContainer: NSPersistentContainer) {
		_viewModel = ObservedObject(wrappedValue: CountryViewModel(container: persistentContainer))
	}

	var body: some View {
		TabView {
			CountryListView(viewModel: viewModel)
				.tabItem {
					Label("Countries", systemImage: "globe")
				}
			FavoriteListView(viewModel: viewModel)
				.tabItem {
					Label("Favorites", systemImage: "star.fill")
				}
		}
	}
}
