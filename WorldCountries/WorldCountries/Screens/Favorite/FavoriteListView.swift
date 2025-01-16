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
							NavigationLink(destination: CountryDetailView(viewModel: viewModel, country: country)) {
								CountryRow(country: country)
							}
						}
						.onDelete(perform: delete)
					}
				}
			}
			.navigationTitle("Favorites")
		}
	}
	
	func delete(at offsets: IndexSet) {
		viewModel.favoriteCountries.remove(atOffsets: offsets)
	}
}

