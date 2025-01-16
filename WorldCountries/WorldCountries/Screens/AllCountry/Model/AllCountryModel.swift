//
//  AllCountryModel.swift
//  WorldCountries
//
//  Created by Кирилл Коновалов on 16.01.2025.
//

import Foundation

struct AllCountryModel: Codable, Identifiable, Hashable {
	var id: String { name?.common ?? UUID().uuidString }
	let name: Name?
	let region: String?
	let population: Int?
	let area: Double?
	let capital: [String]?
	let currencies: [String: Currency]?
	let languages: [String: String]?
	let timezones: [String]?
	let latlng: [Double]?
	let flags: Flags?
	let translations: Translations?
	
	struct Name: Codable, Hashable {
		let common: String?
		let official: String?
	}
	
	struct Flags: Codable, Hashable {
		let png: String?
		let svg: String?
	}
	
	struct Currency: Codable, Hashable {
		let name: String?
		let symbol: String?
	}
	
	struct Translations: Codable, Hashable {
			let rus: Translation?
			let eng: Translation?

			struct Translation: Codable, Hashable {
				let common: String?
			}

			/// Получение локализованного имени страны
			var localizedName: String? {
				let languageCode = Locale.current.language.languageCode?.identifier
				switch languageCode {
				case "ru":
					return rus?.common
				default:
					return eng?.common
				}
			}
		}
}
