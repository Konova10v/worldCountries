//
//  CountryRow.swift
//  WorldCountries
//
//  Created by Кирилл Коновалов on 16.01.2025.
//

import SwiftUI

struct CountryRow: View {
	let country: AllCountryModel?
	let favorite: Bool
	let name: String?
	let region: String?
	let flag: String?
	
	var body: some View {
		HStack {
			if let flagURL = favorite ? flag : country?.flags?.png, let url = URL(string: flagURL) {
				AsyncImage(url: url) { image in
					image
						.resizable()
						.scaledToFill()
						.frame(width: 50, height: 30)
						.cornerRadius(5)
				} placeholder: {
					Rectangle()
						.fill(Color.gray.opacity(0.3))
						.frame(width: 50, height: 30)
						.cornerRadius(5)
				}
			}
			
			VStack(alignment: .leading) {
				Text(favorite ? name ?? "No data" : country?.name?.common ?? "No data")
					.font(.headline)
				Text(favorite ? region ?? "No data" : country?.region ?? "No data")
					.font(.subheadline)
					.foregroundColor(.secondary)
			}
		}
		.padding(.vertical, 5)
	}
}
