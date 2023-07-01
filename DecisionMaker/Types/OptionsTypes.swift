//
//  OptionsTypes.swift
//  DecisionMaker
//
//  Created by Emma Sinclair on 6/30/23.
//

import Foundation

class OptionAttribute: ObservableObject, Codable, CustomStringConvertible {
	@Published var value: String = ""
	@Published var goodness: BoundFloat = BoundFloat(0)
	
	init(value: String = "", goodness: BoundFloat = BoundFloat(0)) {
		self.value = value
		self.goodness = goodness
	}
	
	enum CodingKeys: CodingKey {
		case value, goodness
	}

	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		value = try container.decode(String.self, forKey: .value)
		goodness = try container.decode(BoundFloat.self, forKey: .goodness)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(value, forKey: .value)
		try container.encode(goodness, forKey: .goodness)
	}
	
	var description: String {
		"OptionAttribute("
		+ "\"\(value)\""
		+ ", "
		+ "\(goodness.description)"
		+ ")"
	}
}

class Option: ObservableObject, Codable, CustomStringConvertible, Hashable, Identifiable {
	var id = UUID()
	@Published var title: String
	
	private var map: [StaticAttribute: OptionAttribute] = [:]
	
	enum CodingKeys: CodingKey {
		case id, title, map
	}

	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		id = try container.decode(UUID.self, forKey: .id)
		title = try container.decode(String.self, forKey: .title)
		map = try container.decode([StaticAttribute: OptionAttribute].self, forKey: .map)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(id, forKey: .id)
		try container.encode(title, forKey: .title)
		try container.encode(map, forKey: .map)
	}
	
	init(title: String = "") {
		self.title = title
	}
	
	var description: String {
		return "Option(\"\(title)\")"
	}
	
	static func == (lhs: Option, rhs: Option) -> Bool {
		lhs.id == rhs.id
	}
	
	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}
	
	func getOptionAttributes() -> [OptionAttribute] { Array(map.values) }
	
	func getOptionAttribute(for staticAttribute: StaticAttribute) -> OptionAttribute {
		if map[staticAttribute] == nil {
			map[staticAttribute] = OptionAttribute()
		}
		
		// For the compiler
		guard let optionAttribute = map[staticAttribute] else {
			return OptionAttribute()
		}
		
		return optionAttribute
	}
	
	func setOptionAttribute(
		_ optionAttribute: OptionAttribute,
		for staticAttribute: StaticAttribute
	) {
		map[staticAttribute] = optionAttribute
	}
	
	func setOptionAttributeGoodness(
		_ goodness: BoundFloat,
		for staticAttribute: StaticAttribute
	) {
		let optionAttribute = getOptionAttribute(for: staticAttribute)
		optionAttribute.goodness = goodness
		setOptionAttribute(optionAttribute, for: staticAttribute)
	}
}
