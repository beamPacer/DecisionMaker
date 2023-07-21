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
	@Published var optionAttributes: [OptionAttribute] = []

	init(title: String = "", optionAttributes: [OptionAttribute] = []) {
		self.title = title
	}

	func getOptionAttribute(for staticAttribute: StaticAttribute) -> OptionAttribute {
		return optionAttributes.first { $0.staticAttribute == staticAttribute }
		?? OptionAttribute(value: "", goodness: BoundFloat(0), staticAttribute: staticAttribute)
	}

	func setOptionAttribute(
		_ optionAttribute: OptionAttribute
	) {
		if optionAttributes.contains(where: { $0.staticAttribute == optionAttribute.staticAttribute }) {
			optionAttributes = optionAttributes.map {
				$0.staticAttribute == optionAttribute.staticAttribute ?
				optionAttribute :
				$0
			}
		} else {
			optionAttributes.append(optionAttribute)
		}
	}

	func setOptionAttributeGoodness(
		_ goodness: BoundFloat,
		for staticAttribute: StaticAttribute
	) {
		var optionAttribute = getOptionAttribute(for: staticAttribute)
		optionAttribute.goodness = goodness
		setOptionAttribute(optionAttribute)
	}
	
	// MARK: Codable conformance
	
	enum CodingKeys: CodingKey {
		case id
		case title
		// legacy
		case map
		case optionAttributes
	}

	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		id = try container.decode(UUID.self, forKey: .id)
		title = try container.decode(String.self, forKey: .title)
		if let map = try? container.decode([StaticAttribute: OptionAttribute].self, forKey: .map) {
			optionAttributes = map.map {
				OptionAttribute(
					value: $0.value.value,
					goodness: $0.value.goodness,
					staticAttribute: $0.key
				)
			}
		} else {
			optionAttributes = try container.decode([OptionAttribute].self, forKey: .optionAttributes)
		}
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(id, forKey: .id)
		try container.encode(title, forKey: .title)
		try container.encode(optionAttributes, forKey: .optionAttributes)
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
