//
//  FavoriteListView.swift
//  WorldCountries
//
//  Created by Кирилл Коновалов on 16.01.2025.
//

import SwiftUI

struct FavoriteListView: View {
	@ObservedObject var viewModel: CountryViewModel

	var body: some View {
		NavigationView {
			VStack {
				if viewModel.favoriteCountries.isEmpty {
					Spacer()
					
					Text("No selected countries")
					
					Spacer()
				} else {
					List {
						ForEach(viewModel.favoriteCountries, id: \.self) { country in
							CountryRow(country: nil, favorite: true, name: country.name, region: country.region, flag: country.flagURL)
						}
						.onDelete(perform: delete)
					}
				}
			}
			.navigationTitle("Favorites")
		}
	}
	
	private func delete(at offsets: IndexSet) {
		viewModel.delete(at: offsets)
	}
}

