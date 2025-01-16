//
//  ContentView.swift
//  WorldCountries
//
//  Created by Кирилл Коновалов on 16.01.2025.
//

import SwiftUI

struct CountryListView: View {
	@ObservedObject var viewModel: CountryViewModel

	var body: some View {
		NavigationView {
			VStack {
				if viewModel.filteredCountries.isEmpty {
					Spacer()
					
					ProgressView()
					
					Spacer()
				} else {
					List(viewModel.filteredCountries) { country in
						NavigationLink(destination: CountryDetailView(viewModel: viewModel, country: country)) {
							CountryRow(country: country)
						}
					}
				}
			}
			.searchable(text: $viewModel.searchQuery)
			.navigationTitle("Countries")
		}
		.alert("Failed to upload", isPresented: $viewModel.loadError) {
			Button("Try again", role: .cancel) {
				viewModel.getAllCountries()
			}
		}
	}
}
