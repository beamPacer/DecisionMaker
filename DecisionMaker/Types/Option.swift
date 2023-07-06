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

	init(title: String = "") {
		self.title = title
	}
	
	// MARK: Codable conformance
	
	enum CodingKeys: CodingKey {
		case id, title, map
	}

	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		id = try container.decode(UUID.self, forKey: .id)
		title = try container.decode(String.self, forKey: .title)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(id, forKey: .id)
		try container.encode(title, forKey: .title)
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
