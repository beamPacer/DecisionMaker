//
//  OptionsTypes.swift
//  DecisionMaker
//
//  Created by Emma Sinclair on 6/30/23.
//

import Foundation

class OptionAttribute: ObservableObject, Codable {
	@Published var value: String = ""
	@Published var goodness: BoundFloat = BoundFloat(0)
	var staticAttribute: StaticAttribute

	init(value: String = "", goodness: BoundFloat = BoundFloat(0), staticAttribute: StaticAttribute) {
		self.value = value
		self.goodness = goodness
		self.staticAttribute = staticAttribute
	}
	
	// MARK: Codable conformance

	enum CodingKeys: CodingKey {
		case value, goodness, staticAttribute
	}

	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		value = try container.decode(String.self, forKey: .value)
		goodness = try container.decode(BoundFloat.self, forKey: .goodness)
		staticAttribute = try container.decode(StaticAttribute.self, forKey: .staticAttribute)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(value, forKey: .value)
		try container.encode(goodness, forKey: .goodness)
		try container.encode(staticAttribute, forKey: .staticAttribute)
	}
}

// MARK: CustomStringConvertible conformance

extension OptionAttribute: CustomStringConvertible {
	var description: String {
		"OptionAttribute("
		+ "\"\(value)\""
		+ ", "
		+ "\(goodness.description)"
		+ ")"
	}
}
