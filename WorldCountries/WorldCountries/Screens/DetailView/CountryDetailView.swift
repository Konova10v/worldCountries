//
//  CountryDetailView.swift
//  WorldCountries
//
//  Created by Кирилл Коновалов on 16.01.2025.
//

import SwiftUI
import MapKit

struct CountryDetailView: View {
	@ObservedObject var viewModel: CountryViewModel
	let country: AllCountryModel
	
	var body: some View {
		ScrollView {
			VStack(alignment: .leading, spacing: 20) {
				// Флаг страны
				if let flagURL = country.flags?.png, let url = URL(string: flagURL) {
					AsyncImage(url: url) { image in
						image
							.resizable()
							.scaledToFit()
							.frame(height: 200)
							.cornerRadius(10)
					} placeholder: {
						Rectangle()
							.fill(Color.gray.opacity(0.3))
							.frame(height: 200)
					}
				}
				
				// Официальное название
				Text(country.translations?.localizedName ?? country.name?.official ?? "No data")
					.font(.title)
					.bold()
				
				// Столица
				Text("Capital: \(country.capital?.joined(separator: ", ") ?? "No data")")
				
				// Население
				Text("Population: \(country.population.map { "\($0)" } ?? "No data")")
				
				// Площадь
				Text("Area: \(country.area.map { "\($0) km²" } ?? "No data")")
				
				// Валюта
				if let currencies = country.currencies {
					Text("Currencies: \(currencies.map { "\($1.name ?? "") (\($1.symbol ?? ""))" }.joined(separator: ", "))")
				}
				
				// Языки
				if let languages = country.languages {
					Text("Languages: \(languages.values.joined(separator: ", "))")
				}
				
				// Часовые пояса
				Text("Timezones: \(country.timezones?.joined(separator: ", ") ?? "No data")")
				
				// Карта
				if let latlng = country.latlng, latlng.count == 2 {
					MapView(coordinate: CLLocationCoordinate2D(latitude: latlng[0], longitude: latlng[1]))
						.frame(height: 200)
						.cornerRadius(10)
				}
			}
			.padding()
		}
		.navigationTitle(country.name?.common ?? "")
		.toolbar {
			ToolbarItemGroup(placement: .primaryAction) {
				Button(action: {
					viewModel.toggleFavorite(country: country)
				}) {
					Image(systemName: viewModel.isFavorite(country: country) ? "star.fill" : "star")
				}
				
				Button(action: {
					shareCountryInfo()
				}) {
					Image(systemName: "square.and.arrow.up")
				}
			}
		}
	}
	
	func shareCountryInfo() {
		let text = """
		Страна: \(country.name?.common ?? "Нет данных")
		Официальное название: \(country.name?.official ?? "Нет данных")
		Столица: \(country.capital?.joined(separator: ", ") ?? "Нет данных")
		Население: \(country.population.map { "\($0)" } ?? "Нет данных")
		Площадь: \(country.area.map { "\($0) km²" } ?? "Нет данных")
		"""
		let activityVC = UIActivityViewController(activityItems: [text], applicationActivities: nil)
		if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
			windowScene.keyWindow?.rootViewController?.present(activityVC, animated: true, completion: nil)
		}
	}
}

struct MapView: UIViewRepresentable {
	let coordinate: CLLocationCoordinate2D
	
	func makeUIView(context: Context) -> MKMapView {
		let mapView = MKMapView()
		mapView.setRegion(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5)), animated: false)
		return mapView
	}
	
	func updateUIView(_ uiView: MKMapView, context: Context) {}
}
