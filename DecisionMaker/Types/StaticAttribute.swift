//
//  StaticAttributeTypes.swift
//  DecisionMaker
//
//  Created by Emma Sinclair on 6/30/23.
//

import SwiftUI

struct StaticAttribute: Codable {
	var id = UUID()
	@State var title: String = ""
	@State var importance: BoundFloat = BoundFloat(0)
	var emoji: String = Strings.Common.defaultEmoji

	init(title: String = "", importance: BoundFloat = BoundFloat(0), emoji: String? = nil) {
		self.title = title
		self.importance = importance
		self.emoji = emoji != nil ? emoji! : EmojiHandler.shared.emoji(for: title) ?? Strings.Common.defaultEmoji
	}
}

// MARK: Codable conformance

extension StaticAttribute {
	enum CodingKeys: CodingKey {
		case id, title, importance, emoji
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		id = try container.decode(UUID.self, forKey: .id)
		title = try container.decode(String.self, forKey: .title)
		importance = try container.decode(BoundFloat.self, forKey: .importance)
		emoji = try container.decode(String.self, forKey: .emoji)
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(id, forKey: .id)
		try container.encode(title, forKey: .title)
		try container.encode(importance, forKey: .importance)
		try container.encode(emoji, forKey: .emoji)
	}
}

// MARK: Identifiable conformance

extension StaticAttribute: Identifiable {}

// MARK: Hashable conformance

extension StaticAttribute: Hashable {
	static func == (lhs: StaticAttribute, rhs: StaticAttribute) -> Bool {
		lhs.id == rhs.id
	}

	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}
}

// MARK: CustomStringConvertible conformance

extension StaticAttribute: CustomStringConvertible {
	var description: String {
		"StaticAttribute("
		+ "\"\(title)\""
		+ ", "
		+ "\(importance.description)"
		+ ")"
	}
}

