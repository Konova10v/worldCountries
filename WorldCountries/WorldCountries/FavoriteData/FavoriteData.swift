//
//  FavoriteData.swift
//  WorldCountries
//
//  Created by Кирилл Коновалов on 17.01.2025.
//

import SwiftData
import Foundation

@Model
class FavoriteData {
	@Attribute var id: String
	@Attribute var region: String
	@Attribute var population: Int
	@Attribute var area: Double
	@Attribute var capital: [String]
	@Attribute var timezones: [String]
	@Attribute var latlng: [Double]
	
	@Relationship var flags: FavoriteDataFlags?
	@Relationship var translations: FavoriteDataTranslations?
	@Relationship var currencies: [FavoriteDataCurrency]
	@Relationship var name: FavoriteDataName

	// Инициализатор
	init(id: String = UUID().uuidString, region: String, population: Int, area: Double, capital: [String], timezones: [String], latlng: [Double], flags: FavoriteDataFlags? = nil, translations: FavoriteDataTranslations? = nil, currencies: [FavoriteDataCurrency], name: FavoriteDataName) {
		self.id = id
		self.region = region
		self.population = population
		self.area = area
		self.capital = capital
		self.timezones = timezones
		self.latlng = latlng
		self.flags = flags
		self.translations = translations
		self.currencies = currencies
		self.name = name
	}

	// Вычисляемое свойство
	var localizedName: String {
		let languageCode = Locale.current.language.languageCode?.identifier
		if let translations = translations {
			switch languageCode {
			case "ru":
				return translations.rus?.common ?? "Unknown"
			default:
				return translations.eng?.common ?? "Unknown"
			}
		}
		return "Unknown"
	}
}

@Model
class FavoriteDataName {
	@Attribute var common: String
	@Attribute var official: String
	
	init(common: String, official: String) {
		self.common = common
		self.official = official
	}
}

@Model
class FavoriteDataFlags {
	@Attribute var png: String
	@Attribute var svg: String
	
	init(png: String, svg: String) {
		self.png = png
		self.svg = svg
	}
}

@Model
class FavoriteDataCurrency {
	@Attribute var name: String
	@Attribute var symbol: String
	
	init(name: String, symbol: String) {
		self.name = name
		self.symbol = symbol
	}
}

@Model
class FavoriteDataTranslations {
	@Relationship var rus: FavoriteDataTranslation?
	@Relationship var eng: FavoriteDataTranslation?
	
	init(rus: FavoriteDataTranslation?, eng: FavoriteDataTranslation?) {
		self.rus = rus
		self.eng = eng
	}
}

@Model
class FavoriteDataTranslation {
	@Attribute var common: String
	
	init(common: String) {
		self.common = common
	}
}
