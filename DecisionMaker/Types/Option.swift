//
//  Option.swift
//  DecisionMaker
//
//  Created by Emma Sinclair on 7/6/23.
//

import Foundation

class Option: ObservableObject, Codable {
	var id = UUID()
	@Published var title: String

	private var map: [StaticAttribute: OptionAttribute] = [:]

	init(title: String = "") {
		self.title = title
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
	
	// MARK: Codable conformance
	
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
}

// MARK: Hashable conformance

extension Option: Hashable {
	static func == (lhs: Option, rhs: Option) -> Bool {
		lhs.id == rhs.id
	}

	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}
}

// MARK: CustomStringConvertible conformance

extension Option: CustomStringConvertible {
	var description: String {
		return "Option(\"\(title)\")"
	}
}
