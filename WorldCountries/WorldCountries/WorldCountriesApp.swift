//
//  WorldCountriesApp.swift
//  WorldCountries
//
//  Created by Кирилл Коновалов on 16.01.2025.
//

import SwiftUI

@main
struct WorldCountriesApp: App {
	@ObservedObject private var viewModel = CountryViewModel()
    var body: some Scene {
		WindowGroup {
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
}
