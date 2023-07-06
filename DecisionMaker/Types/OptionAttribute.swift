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

	init(value: String = "", goodness: BoundFloat = BoundFloat(0)) {
		self.value = value
		self.goodness = goodness
	}
	
	// MARK: Codable conformance

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
